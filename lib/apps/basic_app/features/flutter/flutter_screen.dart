import 'package:flutter/material.dart';

import '../../../../core/widgets/code.dart';

class FlutterScreen extends StatelessWidget {
  const FlutterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Code(
              '''flutter pub run build_runner watch -d''',
              title: '코드 생성(Code Generation)',
            ),
            SizedBox(
              height: 5,
            ),
            Code(
              '''flutter run -d Windows -v''',
              title: '윈도우 런 자세히 디버깅',
            ),
            SizedBox(
              height: 10,
            ),
            Code(
              '''
    flutter build ios
    
    flutter build appbundle =>app-release.aap
    flutter build apk =>app-release.apk
    
    flutter build windows
              
              ''',
              title: '빌드',
            )
          ]),
        ),
      ),
    );
  }
}
