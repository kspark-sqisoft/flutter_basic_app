import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/models/chat_user.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

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
}
