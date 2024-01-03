import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class NewFeedScreen extends StatefulWidget {
  const NewFeedScreen({super.key});

  @override
  State<NewFeedScreen> createState() => _NewFeedScreenState();
}

class _NewFeedScreenState extends State<NewFeedScreen> {
  SheetController controller = SheetController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          '게시물 만들기',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: SlidingSheet(
        controller: controller,
        backdropColor: Colors.transparent,
        color: Colors.white,
        extendBody: true,
        closeOnBackdropTap: true,
        listener: (state) {
          //log('state:$state');
        },
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [
            0.1,
            0.7,
            1.0,
          ],

          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),

        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    backgroundImage:
                        AssetImage('assets/images/facebook/profile.jpg'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('박기순'),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userGroup,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '친구만',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FaIcon(
                                FontAwesomeIcons.caretDown,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userGroup,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '사진첩',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FaIcon(
                                FontAwesomeIcons.caretDown,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userGroup,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '해제',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FaIcon(
                                FontAwesomeIcons.caretDown,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const Flexible(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: '무슨 생각을 하고 계신가요?',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return SheetListenerBuilder(
            //buildWhen: (oldState, newState) =>
            //    oldState.isExpanded != newState.isExpanded,
            builder: (context, state) {
              final isExpanded = state.isExpanded;
              final isAtBottom = state.isAtBottom;
              final isAtTop = state.isAtTop;
              final isCollapsed = state.isCollapsed;
              log('build isExpanded:$isExpanded isAtBottom:$isAtBottom isAtTop:$isAtTop isCollapsed:$isCollapsed');

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: isCollapsed
                            ? const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.images,
                                    color: Colors.lightGreen,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.user,
                                    color: Colors.lightBlue,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    color: Colors.amber,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.locationDot,
                                    color: Colors.red,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.video,
                                    color: Colors.red,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.font,
                                    color: Colors.lightGreen,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.lightBlue,
                                  ),
                                ],
                              )
                            : ListView(
                                children: const [
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.images,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('사진/동영상')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.user,
                                        color: Colors.lightBlue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('사람 태그')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('기분/활동')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.locationDot,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('체크인')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.video,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('라이브 방송')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.font,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('배경 색상')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.lightBlue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('카메라')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.image,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('GIF')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.music,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('음악')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.calendarDay,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('이벤트 태그')
                                    ],
                                  ),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
