import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../firebase_app.dart';
import '../api/apis.dart';
import 'models/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.chatUser});
  final ChatUser chatUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: Column(
          children: [
            SizedBox(
              width: mq.width,
              height: mq.height * .03,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .1),
              child: CachedNetworkImage(
                width: mq.height * .2,
                height: mq.height * .2,
                fit: BoxFit.fill,
                imageUrl: widget.chatUser.image!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              width: mq.width,
              height: mq.height * .03,
            ),
            Text(
              widget.chatUser.email!,
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(
              width: mq.width,
              height: mq.height * .03,
            ),
            TextFormField(
              initialValue: widget.chatUser.name!,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'eg. Happy Singh',
                  label: const Text('Name')),
            ),
            SizedBox(
              width: mq.width,
              height: mq.height * .02,
            ),
            TextFormField(
              initialValue: widget.chatUser.about!,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'eg. Feeling Happy',
                  label: const Text('About')),
            ),
            SizedBox(
              height: mq.height * .05,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(mq.width * .4, mq.height * .055)),
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 28,
                ),
                label: const Text(
                  'Update',
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
