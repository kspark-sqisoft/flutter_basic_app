import 'dart:math';
import 'package:scroll_pos/scroll_pos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<CardData> cardDatas = [
  CardData(
    day: 'Mon',
    dayNum: '1',
    month: 'Jan',
    todos: [
      'Eliga Order 주간회의',
      '사업부 주간회의',
    ],
  ),
  CardData(
    day: 'Tue',
    dayNum: '2',
    month: 'Jan',
    todos: [
      '중앙박물관 주간회의',
      '신년회(전체)',
      '전기안전공사 킥오프',
    ],
  ),
  CardData(
    day: 'Wed',
    dayNum: '3',
    month: 'Jan',
    todos: [
      '아이넷시스템 미팅',
      'CRM 교육',
    ],
  ),
  CardData(
    day: 'Thu',
    dayNum: '4',
    month: 'Jan',
    todos: [
      '캠코 자산관리공사 LED 모듈 점검',
    ],
  ),
  CardData(
    day: 'Fri',
    dayNum: '5',
    month: 'Jan',
    todos: [
      '내 생일',
    ],
  ),
  CardData(
    day: 'Sat',
    dayNum: '6',
    month: 'Jan',
    todos: [
      'BMW 유지보수',
    ],
  ),
  CardData(
    day: 'Sun',
    dayNum: '7',
    month: 'Jan',
    todos: [
      '코오롱스포츠',
      '스타필드수원 55',
    ],
  ),
];

final selectIndexProvider = StateProvider<int>((ref) => -1);

class Matrix4Screen extends ConsumerStatefulWidget {
  const Matrix4Screen({super.key});

  @override
  ConsumerState<Matrix4Screen> createState() => _Matrix4ScreenState();
}

class _Matrix4ScreenState extends ConsumerState<Matrix4Screen> {
  late final ScrollPosController _scrollController;
  late final ScrollPosController _topScrollController;
  final GlobalKey _listKey = GlobalKey();
  List<GlobalKey> globalKeys = [];
  int centerItemIndex = 7;

  final int itemTotal = 30;

  @override
  void initState() {
    _scrollController = ScrollPosController(itemCount: itemTotal);
    _topScrollController = ScrollPosController(itemCount: itemTotal);
    if (globalKeys.isEmpty) {
      globalKeys = List.generate(
        itemTotal,
        (index) => GlobalKey(debugLabel: index.toString()),
      );

      _scrollController.addListener(() {
        centerItemIndex = getCenterItemIndex();
        //print('centerItemIndex:$centerItemIndex');
        if (centerItemIndex != -1) {
          //스크롤 하면 선택
          ref.read(selectIndexProvider.notifier).state = centerItemIndex;
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _topScrollController.dispose();
    super.dispose();
  }

  int getCenterItemIndex() {
    final listViewBox =
        _listKey.currentContext!.findRenderObject() as RenderBox?;
    final listViewTop = listViewBox!.localToGlobal(Offset.zero).dy;
    final listViewBottom = listViewTop + listViewBox.size.height;
    final listViewCenter =
        listViewTop + listViewBox.size.height / 2 - 200; //원래 200 없음

    for (var i = 0; i < itemTotal; i++) {
      var itemTop = 0.0;
      var itemBottom = 0.0;
      try {
        final itemBox =
            globalKeys[i].currentContext!.findRenderObject() as RenderBox?;
        itemTop = itemBox!.localToGlobal(Offset.zero).dy;
        itemBottom = itemTop + itemBox.size.height;
      } catch (e) {
        // handle exception if item is not visible
      }

      if (itemTop > listViewBottom) {
        break;
      }

      if (itemTop <= listViewCenter && itemBottom >= listViewCenter) {
        return i;
      }
    }

    return -1; // if no item is in the center of the screen
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectIndexProvider, (prev, next) {
      if (next != -1) {
        if (prev != next) {
          print('next:$next');
          _topScrollController.scrollToItem(next, center: true);
          //_scrollController.scrollToItem(next, center: true);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrix4'),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.00082)
              ..setTranslationRaw(0, -520, 0)
              ..rotateX(-0.8),
            alignment: FractionalOffset.center,
            child: SizedBox(
              width: double.infinity,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  key: _listKey,
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemTotal,
                  itemBuilder: (context, index) => CardItem(
                    key: globalKeys[index],
                    index: index,
                    data: cardDatas[index % 7],
                    scrollPosController: _scrollController,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: itemTotal,
                  controller: _topScrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        ref.read(selectIndexProvider.notifier).state = index;
                      },
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor:
                              ref.watch(selectIndexProvider) == index
                                  ? Colors.red
                                  : Colors.black,
                          radius: 38,
                          child: Text(index.toString()),
                        ),
                      ),
                    ),
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

class CardItem extends ConsumerWidget {
  const CardItem({
    super.key,
    required this.data,
    required this.index,
    required this.scrollPosController,
  });
  final int index;
  final ScrollPosController scrollPosController;
  final CardData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectIndexProvider.notifier).state = index;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(-1.6)
                      ..setTranslationRaw(0, 0, 0),
                    alignment: FractionalOffset.center,
                    child: Text(
                      data.day,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 50, color: Colors.lightBlue),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(-1.6)
                      ..setTranslationRaw(0, 0, -5),
                    alignment: FractionalOffset.center,
                    child: Text(
                      data.day,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 50, color: Colors.white.withOpacity(.8)),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      side: BorderSide(
                        width: index == ref.watch(selectIndexProvider) ? 5 : 2,
                        color: index == ref.watch(selectIndexProvider)
                            ? Colors.white.withOpacity(.9)
                            : Colors.white.withOpacity(.2),
                      )),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2))),
                    child: Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: index % 7 == 0
                                    ? Colors.lightBlue
                                    : Colors.lightGreen.withOpacity(0.4),
                                width: 30)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.day,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Transform(
                                    transform: Matrix4.identity(),
                                    alignment: FractionalOffset.center,
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.amber,
                                        child: Text(
                                          index.toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'JAN',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: Stack(
                                children: [
                                  Transform(
                                    transform: Matrix4.identity()
                                      ..setTranslationRaw(0, 0, 10),
                                    alignment: FractionalOffset.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ...data.todos.map(
                                          (todo) {
                                            return Text(
                                              todo,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(.2),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          },
                                        ).toList()
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ...data.todos.map(
                                        (todo) {
                                          return Text(
                                            todo,
                                            style: const TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          );
                                        },
                                      ).toList()
                                    ],
                                  ),
                                ],
                              )),
                              const Text('2:00 PM - 5:00 PM')
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform(
                  transform: Matrix4.identity()..setTranslationRaw(5, 0, 5),
                  alignment: FractionalOffset.center,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlue.withOpacity(0.8),
                  ),
                ),
                Transform(
                  transform: Matrix4.identity()..setTranslationRaw(5, 0, 0),
                  alignment: FractionalOffset.center,
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage(
                            'assets/images/facebook/user${index % 5}.jpg'),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardData {
  CardData({
    required this.day,
    required this.dayNum,
    required this.month,
    required this.todos,
  });
  final String day;
  final String dayNum;
  final String month;
  final List<String> todos;

  @override
  String toString() {
    return 'CardData(day:$day, dayNum:$dayNum, month:$month, todos:$todos)';
  }
}
