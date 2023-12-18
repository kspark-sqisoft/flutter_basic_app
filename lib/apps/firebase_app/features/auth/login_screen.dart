import 'package:flutter/material.dart';

import '../../firebase_app.dart';
import '../chat/chat_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimatedPosition = false;
  bool _isAnimatedOpacity = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimatedPosition = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isAnimatedOpacity = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to Chat'),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimatedPosition ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            child: Image.asset('assets/images/chat/chat.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width * .9,
            left: mq.width * .05,
            height: mq.height * .07,
            child: AnimatedOpacity(
              opacity: _isAnimatedOpacity ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  shape: const StadiumBorder(),
                  elevation: 1,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChatHomeScreen(),
                      ));
                },
                icon: Image.asset(
                  'assets/images/chat/google.png',
                  height: mq.height * .05,
                ),
                label: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 19),
                    children: [
                      TextSpan(text: 'Sign In with '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
