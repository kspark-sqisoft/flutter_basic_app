import 'package:flutter/material.dart';

import '../../../../core/widgets/code.dart';

class VSCodeScreen extends StatelessWidget {
  const VSCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VSCode'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Theme.of(context).colorScheme.primaryContainer,
              height: 50,
              child: const Center(child: Text('단축키')),
            ),
            const SizedBox(
              height: 5,
            ),
            const Code(
              '''Alt + Shift + A''',
              title: '여러 줄 주석 /** */',
            ),
            const SizedBox(
              height: 5,
            ),
            const Code(
              '''Ctrl + /''',
              title: '여러 줄 주석 //',
            ),
            const SizedBox(
              height: 5,
            ),
            const Code(
              '''Ctrl + /''',
              title: '한 줄 주석',
            ),
            const SizedBox(
              height: 5,
            ),
            const Code(
              '''Ctrl + D''',
              title: '같은 단어 한개 선택 (누를때마다 하나씩 더 추가)',
            ),
            const SizedBox(
              height: 10,
            ),
            const Code(
              '''Ctrl + Shift + L''',
              title: '같은 단어 여러개(모두) 선택',
            ),
            const SizedBox(
              height: 10,
            ),
            const Code(
              '''Shift + Alt+ 마우스 드래그''',
              title: '마우스로 여러개(모두) 선택',
            )
          ]),
        ),
      ),
    );
  }
}
