import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../chat/models/chat_user.dart';
import '../chat/models/message.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static User get currentUser => auth.currentUser!;

  static late ChatUser me;

  static Future<bool> userExists() async {
    return (await fireStore.collection('users').doc(currentUser.uid).get())
        .exists;
  }

  static Future<void> getSelfInfo() async {
    await fireStore.collection('users').doc(currentUser.uid).get().then((user) {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
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

  //나 이외의 유저들 가져오기
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore
        .collection('users')
        .where('id', isNotEqualTo: currentUser.uid)
        .snapshots();
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
        .orderBy('sent', descending: false)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: currentUser.uid,
        sent: time);

    final ref = fireStore
        .collection('chats/${getConversationID(chatUser.id!)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    fireStore
        .collection('chats/${getConversationID(message.fromId!)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}
