import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../features/api/apis.dart';
import '../features/chat/models/chat_user.dart';
import '../features/chat/models/message.dart';
import '../firebase_app.dart';
import '../helper/my_date_util.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message, required this.chatUser});
  final ChatUser chatUser;
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.currentUser.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  //sender or another user message, me
  Widget _blueMessage() {
    //update last read message if sender and receiver are diffenent

    if (widget.message.read!.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                width: mq.height * .045,
                height: mq.height * .045,
                fit: BoxFit.cover,
                imageUrl: widget.chatUser.image!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.05,
            ),
          ],
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mq.width * 0.01),
                child: Text(
                  '${widget.message.fromName}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Container(
                padding: EdgeInsets.all(mq.width * .04),
                margin: EdgeInsets.symmetric(
                    horizontal: mq.width * .01, vertical: mq.height * .005),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 245, 255),
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: const BorderRadius.only(
                      //topLeft: Radius.circular(30), //카카오 주석
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Text(
                  '${widget.message.msg}',
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(time: widget.message.sent!),
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  //our or currentUser message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            SizedBox(
              width: mq.width * .04,
            ),
            //double tick blue icon for message read
            if (widget.message.read!.isNotEmpty)
              const Icon(
                Icons.done_all_rounded,
                color: Colors.blue,
                size: 20,
              ),
            //for adding some space
            const SizedBox(
              width: 2,
            ),
            //sent time
            Text(
              MyDateUtil.getFormattedTime(time: widget.message.sent!),
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .01, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30), //카카오 주석
                  bottomLeft: Radius.circular(30),
                  //bottomRight: Radius.circular(30),
                )),
            child: Text(
              '${widget.message.msg}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
