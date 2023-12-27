import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/constants/firebase_constants.dart';
import '../models/app_user.dart';
import 'handle_exception.dart';

class ProfileRepository {
  Future<AppUser> getProfile({required String uid}) async {
    try {
      log('ProfileRepository getProfile(uid:$uid)');
      final DocumentSnapshot appUserDoc = await usersCollection.doc(uid).get();

      if (appUserDoc.exists) {
        final appUser = AppUser.fromDoc(appUserDoc);
        log('ProfileRepository appUser:$appUser');
        return appUser;
      }

      throw 'User not found';
    } catch (e) {
      throw handleException(e);
    }
  }
}
