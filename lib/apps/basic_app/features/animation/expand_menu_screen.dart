import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuSelectIndexProvider = StateProvider.autoDispose((ref) => -1);

class ExpandMenuScreen extends StatefulWidget {
  const ExpandMenuScreen({super.key});

  @override
  State<ExpandMenuScreen> createState() => _ExpandMenuScreenState();
}

class _ExpandMenuScreenState extends State<ExpandMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExpandMenu')),
      //ListView도 가능(height 지정)
      body: const Wrap(
        children: [
          ExpandItem(
            index: 0,
          ),
          ExpandItem(
            index: 1,
          ),
          ExpandItem(
            index: 2,
          ),
        ],
      ),
    );
  }
}

class ExpandItem extends ConsumerWidget {
  const ExpandItem({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ref.read(menuSelectIndexProvider.notifier).state = index;
        },
        child: Card(
          elevation: 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            width: index == ref.watch(menuSelectIndexProvider) ? 200 : 100,
            height: 200,
            color: Colors.red,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/facebook/friend$index.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  left: 5,
                  bottom: 5,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.directions_walk,
                      color: Color(0xFFED5565),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
