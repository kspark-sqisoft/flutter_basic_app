import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../firebase_app.dart';
import '../../widgets/chat_user_card.dart';
import '../api/apis.dart';
import 'models/chat_user.dart';
import 'profile_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  List<ChatUser> users = [];

  @override
  void initState() {
    APIs.getSelfInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: const Text('Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen(
                        currentUser: APIs.me,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
          stream: APIs.getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                final usersDocs = snapshot.data?.docs;
                users = usersDocs
                        ?.map((userDoc) => ChatUser.fromJson(userDoc.data()))
                        .toList() ??
                    [];

                if (users.isNotEmpty) {
                  return ListView.builder(
                    itemCount: users.length,
                    padding: EdgeInsets.only(top: mq.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ChatUserCard(
                      chatUser: users[index],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No Users Collections Found!',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
            }
          }),
    );
  }
}
