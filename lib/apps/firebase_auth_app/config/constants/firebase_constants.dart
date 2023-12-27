import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//email 로그인 유저스
final usersCollection = FirebaseFirestore.instance.collection('eusers');
final fbAuth = FirebaseAuth.instance;
