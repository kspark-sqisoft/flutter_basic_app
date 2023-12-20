import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../firebase_app.dart';
import '../../widgets/message_card.dart';
import '../api/apis.dart';
import 'models/chat_user.dart';
import 'models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatUser});
  final ChatUser chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  final _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 248, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false, //뒤로 가기 없애기
          flexibleSpace: _appBar(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: APIs.getAllMessages(widget.chatUser),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox();

                    case ConnectionState.active:
                    case ConnectionState.done:
                      final messagesDocs = snapshot.data?.docs;
                      if (messagesDocs != null) {
                        _messages = messagesDocs
                            .map((messageDoc) =>
                                Message.fromJson(messageDoc.data()))
                            .toList();
                      } else {
                        _messages = [];
                      }

                      /*
                      _messages.clear();
                      _messages.add(
                        Message(
                          toId: 'xyz',
                          msg: 'Hii',
                          read: '',
                          type: Type.text,
                          fromId: APIs.currentUser.uid,
                          sent: '12:00 AM',
                        ),
                      );
                      _messages.add(
                        Message(
                          toId: APIs.currentUser.uid,
                          msg: 'Hello',
                          read: '',
                          type: Type.text,
                          fromId: 'xyz',
                          sent: '12:05 AM',
                        ),
                      );
                      */
                      if (_messages.isNotEmpty) {
                        return ListView.builder(
                          itemCount: _messages.length,
                          padding: EdgeInsets.only(top: mq.height * .01),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => MessageCard(
                            message: _messages[index],
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'Say Hi! 👋',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black54,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .03),
              child: CachedNetworkImage(
                width: mq.height * .05,
                height: mq.height * .05,
                fit: BoxFit.cover,
                imageUrl: widget.chatUser.image!,
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatUser.name!,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Last seen not available',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onTap: () {},
                      decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(
                          color: Colors.blueAccent,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blueAccent,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.blueAccent,
                      size: 26,
                    ),
                  ),
                  SizedBox(
                    width: mq.width * .02,
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(
                    widget.chatUser, _textController.text, Type.text);
                _textController.text = '';
              }
            },
            shape: const CircleBorder(),
            color: Colors.green,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            minWidth: 0,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
