import 'package:flutter/material.dart';
import 'package:flutter_folding_card/flutter_folding_card.dart';

class FoldingCardsScreen extends StatefulWidget {
  const FoldingCardsScreen({super.key});

  @override
  State<FoldingCardsScreen> createState() => _FoldingCardsScreenState();
}

class _FoldingCardsScreenState extends State<FoldingCardsScreen> {
  bool _isFoldingOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Folding Cards')),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isFoldingOut = !_isFoldingOut;
          });
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SizedBox(
              width: 600,
              child: FoldingCard(
                foldOut: _isFoldingOut,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 1600),
                coverBackground: Container(
                    color: Colors.grey,
                    child: const Center(child: Text('CoverBackground'))),
                expandedCard: Image.asset(
                  'assets/images/facebook/profile.jpg',
                  width: 600,
                  fit: BoxFit.cover,
                ),
                cover: Image.asset(
                  'assets/images/facebook/user5.jpg',
                  height: 400,
                  fit: BoxFit.cover,
                ),
                foldingHeight: 400,
                expandedHeight: 800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
