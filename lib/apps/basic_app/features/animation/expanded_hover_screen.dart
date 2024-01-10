import 'package:flutter/material.dart';

class ExpandedHoverScreen extends StatelessWidget {
  const ExpandedHoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> testImages = [
      'https://m.media-amazon.com/images/M/MV5BNDU0MjViZmQtNzdmZS00YjhlLWE4ZGMtMDJlODAzMGI5ODIwXkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BY2Y5MThlMDAtMTlmMC00ODNjLWIzM2UtNDhlZTFmN2VlNjRkXkEyXkFqcGdeQXVyNjA3OTI5MjA@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BNTM0YmJmMGMtMmYyMC00YTU3LWEzNjQtODU4NjQ3YjY3NTU1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODQ1Y2FiNzItNjdkZi00ZmRiLTllZjgtZjA2MTIyNWFjOGZhXkEyXkFqcGdeQXVyOTE1NzI0NDg@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYmRhZDJmN2QtYjU4NC00Y2QxLTkwNWMtYzVlODU5YzcyZjA2XkEyXkFqcGdeQXVyMTMzOTM3NDUx._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BNjRhOTQ4ZGEtNDBkOS00N2E5LWJlMDUtM2MxZDg5MGVhOWE5XkEyXkFqcGdeQXVyOTQ0MDUwOTM@._V1_.jpg',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('ExpandedHover')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: testImages.length,
              itemBuilder: (context, index) {
                return HoverCard(
                  image: testImages[index],
                  isAssetImage: false,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  const HoverCard({
    required this.image,
    this.width = 100,
    this.expandedWidth = 200,
    this.height = 200,
    this.duration = 500,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.curve = Curves.easeInOutCubic,
    this.reverseCurve = Curves.easeInOutCirc,
    this.margin = const EdgeInsets.all(4),
    this.isAssetImage = true,
    this.fit = BoxFit.cover,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final String image;
  final double width;
  final double expandedWidth;
  final double height;
  final int duration;
  final BorderRadius borderRadius;
  final Curve curve;
  final Curve reverseCurve;
  final EdgeInsetsGeometry margin;
  final bool isAssetImage;
  final BoxFit fit;
  final void Function()? onTap;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );

    _widthAnimation =
        Tween<double>(begin: widget.width, end: widget.expandedWidth).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) {
        _animationController.forward();
      },
      onExit: (details) {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return InkWell(
            onTap: widget.onTap,
            onLongPress: () => _animationController.reverse(),
            child: Container(
              height: widget.height,
              width: _widthAnimation.value,
              margin: widget.margin,
              child: child,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.isAssetImage
              ? Image.asset(
                  widget.image,
                  fit: widget.fit,
                )
              : Image.network(
                  widget.image,
                  fit: widget.fit,
                ),
        ),
      ),
    );
  }
}
