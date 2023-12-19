import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../firebase_app.dart';
import '../../helper/diolog.dart';
import '../api/apis.dart';
import '../auth/login_screen.dart';
import 'models/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.currentUser});
  final ChatUser currentUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              Dialogs.showProgressbar(context);
              await APIs.auth.signOut().then(
                (value) async {
                  await GoogleSignIn().signOut();
                  if (!context.mounted) return;
                  //remove progress dialog
                  Navigator.pop(context);
                  //move home screen
                  Navigator.pop(context);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .1),
                        child: CachedNetworkImage(
                          width: mq.height * .2,
                          height: mq.height * .2,
                          fit: BoxFit.fill,
                          imageUrl: widget.currentUser.image!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          onPressed: () {},
                          elevation: 1,
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  Text(
                    widget.currentUser.email!,
                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  TextFormField(
                    initialValue: widget.currentUser.name!,
                    onSaved: (newValue) =>
                        APIs.me = APIs.me.copyWith(name: newValue ?? ''),
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Required Field',
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
                    initialValue: widget.currentUser.about!,
                    onSaved: (newValue) =>
                        APIs.me = APIs.me.copyWith(about: newValue ?? ''),
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Required Field',
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          log('_formKey.currentState validate');
                          log('changed ${APIs.me}');
                          APIs.updateUserInfo();
                        }
                      },
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
          ),
        ),
      ),
    );
  }
}
