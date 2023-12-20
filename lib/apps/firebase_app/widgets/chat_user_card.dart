import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/api/apis.dart';
import '../features/chat/chat_screen.dart';
import '../features/chat/models/chat_user.dart';
import '../features/chat/models/message.dart';
import '../firebase_app.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.chatUser});
  final ChatUser chatUser;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    Message? message;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  chatUser: widget.chatUser,
                ),
              ));
        },
        child: StreamBuilder(
          stream: APIs.getLastMessage(widget.chatUser),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            if (data != null && data.first.exists) {
              message = Message.fromJson(data.first.data());
            }
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .3),
                child: CachedNetworkImage(
                  width: mq.height * .055,
                  height: mq.height * .055,
                  fit: BoxFit.cover,
                  imageUrl: widget.chatUser.image!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              title: Text('${widget.chatUser.name}'),
              subtitle: Text(
                message != null ? message!.msg! : '${widget.chatUser.about}',
                maxLines: 1,
              ),
              trailing: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
