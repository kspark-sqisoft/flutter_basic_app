import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<ChatUser> _users = [];
  final List<ChatUser> _searchUsers = [];
  bool _isSearchingUsers = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //화면 다른곳 클릭시 키보드 닫기

      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        //true => normal backbutton, false => do nothing
        //검색중 뒤로 가기 누르면 앱 나가지 않게 처리
        canPop: !_isSearchingUsers,
        onPopInvoked: (bool didPop) async {
          log('onPopInvoked didPop:$didPop');
          setState(() {
            _isSearchingUsers = !_isSearchingUsers;
          });
          if (didPop) {
            return;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.home),
            title: _isSearchingUsers
                ? TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name, Email, ...',
                    ),
                    autofocus: true,
                    style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
                    onChanged: (value) {
                      //search logic
                      _searchUsers.clear();
                      for (var user in _users) {
                        if (user.name!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            user.email!
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchUsers.add(user);
                        }
                      }
                      setState(() {});
                    },
                  )
                : const Text('Chat'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearchingUsers = !_isSearchingUsers;
                    });
                  },
                  icon: Icon(_isSearchingUsers
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),
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
                  _users = usersDocs
                          ?.map((userDoc) => ChatUser.fromJson(userDoc.data()))
                          .toList() ??
                      [];

                  if (_users.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _isSearchingUsers
                          ? _searchUsers.length
                          : _users.length,
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ChatUserCard(
                        chatUser: _isSearchingUsers
                            ? _searchUsers[index]
                            : _users[index],
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
            },
          ),
        ),
      ),
    );
  }
}
