import 'package:flutter/material.dart';

import '../../core/theme_controller/theme_controller.dart';
import 'features/animation/animation_basic_screen.dart';
import 'features/animation/animation_screen.dart';
import 'features/animation/expand_menu_screen.dart';
import 'features/animation/expanded_hover_screen.dart';
import 'features/animation/expanding_flex_cards_screen.dart';
import 'features/camera/camera_screen.dart';
import 'features/camera/camera_webview_screen.dart';
import 'features/column_row/column_row_screen.dart';
import 'features/constrainedbox/constrained_box_screen.dart';
import 'features/custom_keyboard/custom_keyboard_screen.dart';
import 'features/customscrollview/customscrollview_screen.dart';
import 'features/customscrollview/super_cupertino_navigation_bar/super_cupertino_navigation_bar_screen.dart';
import 'features/dart/dart_enum_screen.dart';
import 'features/dart/dart_function_screen.dart';
import 'features/dart/dart_generic_screen.dart';
import 'features/dart/dart_oop_screen.dart';
import 'features/dart/dart_record_screen.dart';
import 'features/debounce/debounce_screen.dart';
import 'features/drawer/drawer_navigation_screen.dart';
import 'features/drawer/drawer_screen.dart';
import 'features/drawer/drawer_simple_screen.dart';
import 'features/filedownloader/file_downloader_batch_screen.dart';
import 'features/filedownloader/file_downloader_custom_screen.dart';
import 'features/filedownloader/file_downloader_screen.dart';
import 'features/flutter/flutter_screen.dart';
import 'features/hive/hive_screen.dart';
import 'features/httpdio/httpdio_screen.dart';
import 'features/image/image_filter_screen.dart';
import 'features/image/image_merge_screen.dart';
import 'features/image/image_processing2_screen.dart';
import 'features/image/image_processing_screen.dart';
import 'features/image/image_provider_screen.dart';
import 'features/image/widget_to_image_screen.dart';
import 'features/jsonparsing/json_parsing_screen.dart';
import 'features/layoutbuilder/layoutbuilder_screen.dart';
import 'features/lifecycle/lifecycle2_screen.dart';
import 'features/lifecycle/lifecycle_screen.dart';
import 'features/matrix4/book_flip_screen.dart';
import 'features/matrix4/flip_pannel_screen.dart';
import 'features/matrix4/folding_cards_screen.dart';
import 'features/matrix4/folding_list_screen.dart';
import 'features/matrix4/matrix4_screen.dart';
import 'features/painter/painter_screen.dart';
import 'features/print/print_screen.dart';
import 'features/rxdart/rxdart_screen.dart';
import 'features/serialization/serialization_screen.dart';
import 'features/shapes/shapes_screen.dart';
import 'features/socketio/socketio_screen.dart';
import 'features/tab/tab_controller_screen.dart';
import 'features/tab/tab_page_selector_screen.dart';
import 'features/theme/theme_screen.dart';
import 'features/timeline/timeline_screen.dart';
import 'features/vscode/vscode_screen.dart';
import 'features/widgets/widgets_screen.dart';

class BasicAppHomeScreen extends StatelessWidget {
  const BasicAppHomeScreen({super.key, required this.controller});
  final ThemeController controller;

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Basic App'),
          ),
          SliverPersistentHeader(
              delegate: SliverFixedHeaderDelegate(
                  maxHeight: 50,
                  minHeight: 50,
                  child: Container(
                    color: Colors.lightGreen,
                    child: const Center(child: Text('Basic')),
                  ))),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const VSCodeScreen();
                          },
                        ));
                      },
                      child: const Text('VSCode'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FlutterScreen();
                          },
                        ));
                      },
                      child: const Text('Flutter'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DartRecordScreen();
                          },
                        ));
                      },
                      child: const Text('Dart Record'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DartFunctionScreen();
                          },
                        ));
                      },
                      child: const Text('Dart Function'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DartOOPScreen();
                          },
                        ));
                      },
                      child: const Text('Dart OOP'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DartEnumScreen();
                          },
                        ));
                      },
                      child: const Text('Dart Enum'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DartGenericScreen();
                          },
                        ));
                      },
                      child: const Text('Dart Generic'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const HttpDioScreen();
                          },
                        ));
                      },
                      child: const Text('Http vs Dio'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SerializationScreen();
                          },
                        ));
                      },
                      child: const Text('Serialization'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const JsonParsingScreen();
                          },
                        ));
                      },
                      child: const Text('Json Parsing'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const LifeCycleScreen();
                          },
                        ));
                      },
                      child: const Text('LifeCycle'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const LifeCycle2Screen();
                          },
                        ));
                      },
                      child: const Text('LifeCycle2'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DebounceScreen();
                          },
                        ));
                      },
                      child: const Text('Debounce Throttle'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const RxDartScreen();
                          },
                        ));
                      },
                      child: const Text('RxDart'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FileDownloaderScreen();
                          },
                        ));
                      },
                      child: const Text('File Downloader'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FileDownloaderCustomScreen();
                          },
                        ));
                      },
                      child: const Text('File Downloader Custom'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FileDownloaderBatchScreen();
                          },
                        ));
                      },
                      child: const Text('File Downloader Batch'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const PrintScreen();
                          },
                        ));
                      },
                      child: const Text('Print'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SocketIOScreen();
                          },
                        ));
                      },
                      child: const Text('SocketIO'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const HiveScreen();
                          },
                        ));
                      },
                      child: const Text('Hive'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
              delegate: SliverFixedHeaderDelegate(
                  maxHeight: 50,
                  minHeight: 50,
                  child: Container(
                    color: Colors.lightBlue,
                    child: const Center(child: Text('UI')),
                  ))),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ConstrainedBoxScreen();
                          },
                        ));
                      },
                      child: const Text(
                          'ConstrainedBox, OverflowBox, FittedBox, FractionallySizedBox'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ShapesScreen();
                          },
                        ));
                      },
                      child: const Text('Shapes'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const LayoutBuilderScreen();
                          },
                        ));
                      },
                      child: const Text('LayoutBuilder'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DrawerSimpleScreen();
                          },
                        ));
                      },
                      child: const Text('Drawer Simple'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DrawerNavigationScreen();
                          },
                        ));
                      },
                      child: const Text('Drawer Navigation'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const TabControllerScreen();
                          },
                        ));
                      },
                      child: const Text('Tab TabController'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const TabPageSelectorScreen();
                          },
                        ));
                      },
                      child: const Text('Tab TabPageSelector'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DrawerScreen();
                          },
                        ));
                      },
                      child: const Text('Drawer'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ThemeScreen(
                              controller: controller,
                            );
                          },
                        ));
                      },
                      child: const Text('Theme'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CustomScrollViewScreen();
                          },
                        ));
                      },
                      child: const Text('CustomScrollView'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SuperCupertinoNavigationBarScreen();
                          },
                        ));
                      },
                      child: const Text('SuperCupertinoNavigationBar'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const AnimationScreen();
                          },
                        ));
                      },
                      child: const Text('Animation'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const AnimationBasicScreen();
                          },
                        ));
                      },
                      child: const Text('AnimationBasic'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ExpandMenuScreen();
                          },
                        ));
                      },
                      child: const Text('ExpandMenu'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ExpandingFlexCardsScreen();
                          },
                        ));
                      },
                      child: const Text('ExpandingFlexCards'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ExpandedHoverScreen();
                          },
                        ));
                      },
                      child: const Text('ExpandedHover'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const PainterScreen();
                          },
                        ));
                      },
                      child: const Text('Painter'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Matrix4Screen();
                          },
                        ));
                      },
                      child: const Text('Matrix4'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const BookFlipScreen();
                          },
                        ));
                      },
                      child: const Text('BookFlip'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FoldingCardsScreen();
                          },
                        ));
                      },
                      child: const Text('FoldingCards'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FoldingListScreen();
                          },
                        ));
                      },
                      child: const Text('FoldingList'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FlipPannelScreen();
                          },
                        ));
                      },
                      child: const Text('FlipPannel'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const WidgetsScreen();
                          },
                        ));
                      },
                      child: const Text('Widgets'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const TimelineScreen();
                          },
                        ));
                      },
                      child: const Text('Timeline'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CameraScreen();
                          },
                        ));
                      },
                      child: const Text('Camera'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CameraWebviewScreen();
                          },
                        ));
                      },
                      child: const Text('CameraWebview'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ImageMergeScreen();
                          },
                        ));
                      },
                      child: const Text('ImageMerge'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const WidgetToImageScreen();
                          },
                        ));
                      },
                      child: const Text('WidgetToImage'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ImageProviderScreen();
                          },
                        ));
                      },
                      child: const Text('ImageProvider'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ImageProcessingScreen();
                          },
                        ));
                      },
                      child: const Text('ImageProcessing'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ImageProcessing2Screen();
                          },
                        ));
                      },
                      child: const Text('ImageProcessing2'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ImageFilterScreen();
                          },
                        ));
                      },
                      child: const Text('ImageFilter'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CustomKeyboardScreen();
                          },
                        ));
                      },
                      child: const Text('Custom Keyboard'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ColumnRowScreen();
                          },
                        ));
                      },
                      child: const Text('Column Row'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
