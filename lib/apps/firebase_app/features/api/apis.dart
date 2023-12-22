import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';

import '../chat/models/chat_user.dart';
import '../chat/models/message.dart' as my;

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initialization flutter local notification
  static initLocalNotification() async {
    AndroidInitializationSettings initSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_rauncher');
    DarwinInitializationSettings initSettingsIOS =
        const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    await localNotificationsPlugin.initialize(initSettings);
  }

  static Future<void> cancelLocalNotification() async {
    await localNotificationsPlugin.cancelAll();
  }

  static Future<void> showLocalNotification(
      {required String title, required String body}) async {
    localNotificationsPlugin.show(
      11,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
        ),
        iOS: DarwinNotificationDetails(
          badgeNumber: 1,
          subtitle: '',
        ),
      ),
    );
  }

  static User get currentUser => auth.currentUser!;

  static late ChatUser me;

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await messaging.requestPermission(
      badge: true,
      alert: true,
      sound: true,
    );

    await messaging.getToken().then((t) {
      if (t != null) {
        log('getFirebaseMessagingToken me.pushToken:${me.pushToken}');
        me = me.copyWith(pushToken: t);
        log('me Token: ${me.pushToken}');
      }
    });
    //포그라운드는 알림 받을 안뜸(상태바에)-로컬 노티피케이션으로 띄울수 있다.
    /*
    //for handling foreground messages
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('notification.title: ${message.notification!.title}');
          log('notification.body: ${message.notification!.body}');

          await cancelLocalNotification();
          await showLocalNotification(
              title: message.notification!.title!,
              body: message.notification!.body!);
        }
      },
    );
    */
  }

  static String? initTitle;
  static String? initBody;

  static Future<void> setupInteractedMessage() async {
    //꺼짐 상태에서 열었다.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
    //백그라운드에서 알림을 눌러서 들어온 경우
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOnMessageOppendApp);
  }

  static void _handleInitialMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    log('Open App from Terminated notification - title:${notification?.title} body:${notification?.body} - data:${message.data}');
    initTitle = notification?.title;
    initBody = notification?.body;
  }

  static void _handleOnMessageOppendApp(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    log('onMessageOpenedApp notification - title:${notification?.title} body:${notification?.body} - data:${message.data}');
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    //to 보내고 싶은 사람 pushToken
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "User(me:sender) ID: ${me.id}",
        },
      };
      log('sendPushNotification:$body');

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAA2ljGUgk:APA91bEPJJCQhGhQiSPevJUWhK66x9kgUd30L14sBPS7PxGcMo_78RqHxCWCABSpClKITwybMsgI96KczM3_fEgqrd0CvHj2V6jCcfwt4gDW-3yezw6vpzXLPkNCgBJ-chvvJfO8538N'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static Future<bool> userExists() async {
    return (await fireStore.collection('users').doc(currentUser.uid).get())
        .exists;
  }

  // for adding an chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    final data = await fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != currentUser.uid) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      fireStore
          .collection('users')
          .doc(currentUser.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  static Future<void> getSelfInfo() async {
    await fireStore
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();
        await APIs.updateActiveStatus(true);
        log('me:$me');
      } else {
        createUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      id: currentUser.uid,
      name: currentUser.displayName,
      email: currentUser.email.toString(),
      about: "Hey, I'm using We Chat!",
      image: currentUser.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '',
    );
    return await fireStore
        .collection('users')
        .doc(currentUser.uid)
        .set(chatUser.toJson());
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return fireStore
        .collection('users')
        .doc(currentUser.uid)
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return fireStore
        .collection('users')
        .where('id',
            whereIn: userIds.isEmpty
                ? ['']
                : userIds) //because empty list throws an error
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for adding an user to my user when first message is send
  static Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, my.Type type) async {
    await fireStore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(currentUser.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  static Future<void> updateUserInfo() async {
    await fireStore.collection('users').doc(currentUser.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${currentUser.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me = me.copyWith(image: await ref.getDownloadURL());
    await fireStore
        .collection('users')
        .doc(currentUser.uid)
        .update({'image': me.image});
  }

  // useful for getting conversation id
  static String getConversationID(String id) =>
      currentUser.uid.hashCode <= id.hashCode
          ? '${currentUser.uid}_$id'
          : '${id}_${currentUser.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return fireStore
        .collection('chats/${getConversationID(user.id!)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, my.Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final my.Message message = my.Message(
      toId: chatUser.id,
      msg: msg,
      read: '',
      type: type,
      fromId: currentUser.uid,
      sent: time,
      fromName: currentUser.displayName,
    );

    final ref = fireStore
        .collection('chats/${getConversationID(chatUser.id!)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == my.Type.text ? msg : 'image'));
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(my.Message message) async {
    fireStore
        .collection('chats/${getConversationID(message.fromId!)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser chatUser) {
    return fireStore
        .collection('chats/${getConversationID(chatUser.id!)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id!)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, my.Type.image);
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return fireStore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    log('updateActiveStatus me.pushToken:${me.pushToken}');
    fireStore.collection('users').doc(currentUser.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  //delete message
  static Future<void> deleteMessage(my.Message message) async {
    await fireStore
        .collection('chats/${getConversationID(message.toId!)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == my.Type.image) {
      await storage.refFromURL(message.msg!).delete();
    }
  }

  //update message
  static Future<void> updateMessage(
      my.Message message, String updatedMsg) async {
    await fireStore
        .collection('chats/${getConversationID(message.toId!)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }
}
