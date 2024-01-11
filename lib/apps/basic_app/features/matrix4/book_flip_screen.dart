import 'package:flutter/material.dart';
import 'dart:math';

class BookConstants {
  static const double bookBorderRadius = 25;

  static const Duration animationDuration = Duration(milliseconds: 700);

  static const double perspectiveValue = 0.0015;

  static const double bookInitialScale = 0.45;
}

class BookFlipScreen extends StatefulWidget {
  const BookFlipScreen({super.key});

  @override
  State<BookFlipScreen> createState() => _BookFlipScreenState();
}

class _BookFlipScreenState extends State<BookFlipScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _isOpen = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookFlip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BookFlip(
                  animationController: CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Closed'),
                const SizedBox(width: 5),
                Switch.adaptive(
                  value: _isOpen,
                  onChanged: (_) {
                    if (_animationController.isCompleted) {
                      _animationController.reverse();
                      setState(() => _isOpen = false);
                    } else {
                      _animationController.forward();
                      setState(() => _isOpen = true);
                    }
                  },
                ),
                const SizedBox(width: 5),
                const Text('Open'),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            const Row(
              children: [
                BookFlip(),
                BookFlip(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BookFlip extends StatefulWidget {
  const BookFlip({
    super.key,
    this.initialFlipProgress = 0,
    this.animationController,
  });
  final double initialFlipProgress;
  final Animation<double>? animationController;

  @override
  State<BookFlip> createState() => _BookFlipState();
}

class _BookFlipState extends State<BookFlip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final Animation<double> _flipAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: BookConstants.animationDuration,
      value: widget.initialFlipProgress,
    );

    _animation = widget.animationController ??
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        );

    _flipAnimation = Tween<double>(begin: 1, end: 0).animate(_animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_flipAnimation.value);
    print(-0.25 * _flipAnimation.value);
    return GestureDetector(
      onTap: () {
        print('onTap');
        if (_animationController.isCompleted) {
          _animationController.reverse();
          setState(() => _isOpen = false);
        } else {
          _animationController.forward();
          setState(() => _isOpen = true);
        }
      },
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return FractionalTranslation(
              //translation: const Offset(0, 0),
              //translation: Offset(-0.5 * _flipAnimation.value, 0),
              translation: Offset(-0.25 * _flipAnimation.value, 0),
              child: AnimatedContainer(
                constraints:
                    const BoxConstraints(maxWidth: 600, maxHeight: 300),
                duration: BookConstants.animationDuration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection: TextDirection.rtl,
                  children: [
                    const Flexible(
                      child: BookBack(),
                    ),
                    Flexible(
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, BookConstants.perspectiveValue)
                          ..rotateY(-pi * _flipAnimation.value),
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: [
                            _flipAnimation.value <= 0.5
                                ? const Positioned.fill(child: BookCoverBack())
                                : Positioned.fill(
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2,
                                            BookConstants.perspectiveValue)
                                        ..rotateY(-pi),
                                      alignment: Alignment.center,
                                      child: const BookCoverFront(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BookBack extends StatelessWidget {
  const BookBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 40),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(BookConstants.bookBorderRadius),
          bottomRight: Radius.circular(BookConstants.bookBorderRadius),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(-6, 0),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(6, 0),
          ),
        ],
      ),
      child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BookBack'),
            Text(
              '200',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Reviews',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 8),
            Divider(thickness: 0.8),
            SizedBox(height: 8),
          ]),
    );
  }
}

class BookCoverBack extends StatelessWidget {
  const BookCoverBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 20,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(BookConstants.bookBorderRadius),
          bottomLeft: Radius.circular(BookConstants.bookBorderRadius),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(-6, 0),
          ),
        ],
      ),
      child: const Column(
        children: [
          Column(
            children: [
              Text('BookCoverBack'),
              Avatar(
                imageUrl: 'assets/images/facebook/profile.jpg',
                hasBadge: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookCoverFront extends StatelessWidget {
  const BookCoverFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(BookConstants.bookBorderRadius),
          bottomRight: Radius.circular(BookConstants.bookBorderRadius),
        ),
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(8, 0),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(3, 0),
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade50,
                  Colors.grey.shade200,
                ],
              ),
            ),
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('BookCoverFront'),
                Avatar(
                  imageUrl: 'assets/images/facebook/user4.jpg',
                  hasInnerShadow: true,
                  size: 120,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.imageUrl,
    this.size = 110,
    this.hasBadge = false,
    this.hasInnerShadow = false,
  });
  final String imageUrl;
  final double size;
  final bool hasBadge;
  final bool hasInnerShadow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: hasInnerShadow
                  ? RadialGradient(
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.2),
                      ],
                      stops: const [0.9, 1],
                    )
                  : null,
            ),
          ),
        ),
        if (hasBadge)
          Positioned(
            bottom: 0,
            right: 0,
            width: 35,
            height: 35,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
              ),
              child: const Icon(
                Icons.verified_user_sharp,
                color: Colors.white,
                size: 18,
              ),
            ),
          )
      ],
    );
  }
}
