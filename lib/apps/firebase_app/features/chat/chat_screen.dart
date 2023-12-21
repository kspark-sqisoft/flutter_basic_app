import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../firebase_app.dart';
import '../../helper/my_date_util.dart';
import '../../widgets/message_card.dart';
import '../api/apis.dart';
import 'models/chat_user.dart';
import 'models/message.dart';
import 'view_profile_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatUser});
  //상대방
  final ChatUser chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  final _textController = TextEditingController();
  bool _showEmoji = false;
  bool _isUploading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: !_showEmoji,
        onPopInvoked: (bool didPop) async {
          log('onPopInvoked didPop:$didPop');
          setState(() {
            _showEmoji = !_showEmoji;
          });
          if (didPop) {
            return;
          }
        },
        child: Scaffold(
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
                          if (_messages.isNotEmpty) {
                            return ListView.builder(
                              reverse: true,
                              itemCount: _messages.length,
                              padding: EdgeInsets.only(top: mq.height * .01),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => MessageCard(
                                message: _messages[index],
                                chatUser: widget.chatUser,
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
                //progress indicator for showing uploading
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: CircularProgressIndicator(strokeWidth: 2))),
                //chat input filed
                _chatInput(),
                //show emojis on keyboard emoji button click & vice versa
                if (_showEmoji)
                  SizedBox(height: mq.height * .35, child: _emojiPicker())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewProfileScreen(user: widget.chatUser)));
      },
      child: StreamBuilder(
        stream: APIs.getUserInfo(widget.chatUser),
        builder: (context, snapshot) {
          final usersDocs = snapshot.data?.docs;
          final users = usersDocs
                  ?.map((userDoc) => ChatUser.fromJson(userDoc.data()))
                  .toList() ??
              [];

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Platform.isAndroid ? 0 : 15,
                ),
                Row(
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
                        imageUrl: users.isNotEmpty
                            ? users[0].image!
                            : widget.chatUser.image!,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //user name & last seen time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //user name
                        Text(
                          users.isNotEmpty
                              ? users[0].name!
                              : widget.chatUser.name!,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          users.isNotEmpty
                              ? users[0].isOnline!
                                  ? 'Online'
                                  : MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: users[0].lastActive!)
                              : MyDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.chatUser.lastActive!),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
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
                  //emoji button
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _showEmoji = !_showEmoji;
                      });
                    },
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
                      onTap: () {
                        if (_showEmoji) {
                          setState(() {
                            _showEmoji = !_showEmoji;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(
                          color: Colors.blueAccent,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //pick image from gallery button
                  IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      // Picking multiple images
                      final List<XFile> images =
                          await picker.pickMultiImage(imageQuality: 70);

                      // uploading & sending image one by one
                      for (var i in images) {
                        log('Image Path: ${i.path}');
                        setState(() => _isUploading = true);
                        await APIs.sendChatImage(widget.chatUser, File(i.path));
                        setState(() => _isUploading = false);
                      }
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blueAccent,
                      size: 26,
                    ),
                  ),
                  //take image from camera button
                  IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      // Pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 70);
                      if (image != null) {
                        log('Image Path: ${image.path}');
                        setState(() => _isUploading = true);

                        await APIs.sendChatImage(
                            widget.chatUser, File(image.path));
                        setState(() => _isUploading = false);
                      }
                    },
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

  Widget _emojiPicker() {
    return EmojiPicker(
      textEditingController: _textController,
      config: Config(
        bgColor: const Color.fromARGB(255, 234, 248, 255),
        columns: 8,
        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
      ),
    );
  }
}
