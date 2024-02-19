import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class GalleryItem {
  final String id;
  final String resource;
  GalleryItem({
    required this.id,
    required this.resource,
  });
}

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({super.key});

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  int initialIndex = 0;
  late PageController pageController;
  List<GalleryItem> galleryItems = [
    GalleryItem(id: 'tag1', resource: 'assets/images/facebook/user0.jpg'),
    GalleryItem(id: 'tag2', resource: 'assets/images/facebook/user1.jpg'),
    GalleryItem(id: 'tag3', resource: 'assets/images/facebook/user2.jpg'),
    GalleryItem(id: 'tag4', resource: 'assets/images/facebook/user3.jpg'),
  ];

  late int currentIndex = initialIndex;

  @override
  void initState() {
    pageController = PageController(initialPage: initialIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoView'),
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PhotoViewGallery.builder(
            itemCount: galleryItems.length,
            scrollDirection: Axis.horizontal,
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded.toDouble() /
                          event.expectedTotalBytes!.toDouble(),
                ),
              ),
            ),
            builder: (context, index) {
              final GalleryItem galleryItem = galleryItems[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(galleryItem.resource),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                maxScale: PhotoViewComputedScale.covered * 4.1,
                heroAttributes: PhotoViewHeroAttributes(tag: galleryItem.id),
                filterQuality: FilterQuality.high,
                gestureDetectorBehavior: HitTestBehavior.opaque,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Image ${currentIndex + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                decoration: null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
