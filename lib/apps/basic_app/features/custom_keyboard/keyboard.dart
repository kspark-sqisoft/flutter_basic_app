import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangul/hangul.dart';

import 'custom_keyboard_screen.dart';

enum KeyboardType { engSmall, engBig, korA, korB, num }

class Keyboard extends StatefulWidget {
  const Keyboard({
    super.key,
    required this.onOutput,
    required this.onSearch,
    required this.onReset,
    this.onGoHome,
    this.inputMode,
    this.textEditingController,
  });

  final Function(String) onOutput;
  final Function onSearch;
  final Function onReset;
  final Function? onGoHome;
  final InputMode? inputMode;
  final TextEditingController? textEditingController;

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  static List<String> charEngSmalls = [
    "q",
    "w",
    "e",
    "r",
    "t",
    "y",
    "u",
    "i",
    "o",
    "p",
    "a",
    "s",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "z",
    "x",
    "c",
    "v",
    "b",
    "n",
    "m",
    ",",
    "."
  ];
  static List<String> charEngBigs = [
    "Q",
    "W",
    "E",
    "R",
    "T",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "A",
    "S",
    "D",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
    ",",
    "."
  ];
  static List<String> charKorAs = [
    "ㅂ",
    "ㅈ",
    "ㄷ",
    "ㄱ",
    "ㅅ",
    "ㅛ",
    "ㅕ",
    "ㅑ",
    "ㅐ",
    "ㅔ",
    "ㅁ",
    "ㄴ",
    "ㅇ",
    "ㄹ",
    "ㅎ",
    "ㅗ",
    "ㅓ",
    "ㅏ",
    "ㅣ",
    "ㅋ",
    "ㅌ",
    "ㅊ",
    "ㅍ",
    "ㅠ",
    "ㅜ",
    "ㅡ",
    ",",
    "."
  ];
  static List<String> charKorBs = [
    "ㅃ",
    "ㅉ",
    "ㄸ",
    "ㄲ",
    "ㅆ",
    "ㅛ",
    "ㅕ",
    "ㅑ",
    "ㅒ",
    "ㅖ",
    "ㅁ",
    "ㄴ",
    "ㅇ",
    "ㄹ",
    "ㅎ",
    "ㅗ",
    "ㅓ",
    "ㅏ",
    "ㅣ",
    "ㅋ",
    "ㅌ",
    "ㅊ",
    "ㅍ",
    "ㅠ",
    "ㅜ",
    "ㅡ",
    ",",
    "."
  ];
  static List<String> charNums = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "@",
    "#",
    "€",
    "&",
    "*",
    "(",
    ")",
    "\'",
    "\"",
    "\%",
    "\-",
    "\+",
    "\=",
    "\/",
    ";",
    ":",
    "!",
    "?"
  ];

  KeyboardType seletedKeyboardType = KeyboardType.engSmall;
  List<String> selectedChars = charEngSmalls;

  late List<String> firstRowKeys;
  late List<String> secondRowKeys;
  late List<String> thirdRowKeys;
  late List<String> fourthRowKeys;

  bool isPressedShift = false;
  bool isPressedHangul = true;
  bool isPressedNum = false;

  HangulInput input = HangulInput('');

  Timer? deleteDebounce;
  bool deleteChar = true;

  @override
  void initState() {
    super.initState();
    print('keyboard init');
    if (widget.textEditingController != null) {
      input = HangulInput(widget.textEditingController!.text);
    } else {
      input = HangulInput('');
    }

    setKeyboardType(KeyboardType.korA);
  }

  @override
  void didUpdateWidget(covariant Keyboard oldWidget) {
    print('didUpdateWidget');
    reset();
    super.didUpdateWidget(oldWidget);
  }

  void forceReset() {
    input = HangulInput('');
  }

  void reset() {
    if (widget.textEditingController != null) {
      input = HangulInput(widget.textEditingController!.text);
    } else {
      input = HangulInput('');
    }

    if (widget.inputMode != null) {
      if (widget.inputMode == InputMode.date) {
        setKeyboardType(KeyboardType.num);
      } else {
        setKeyboardType(KeyboardType.korA);
      }
    }

    deleteChar = true;
  }

  void setKeyboardType(KeyboardType keyboardType) {
    switch (keyboardType) {
      case KeyboardType.engBig:
        seletedKeyboardType = KeyboardType.engBig;
        selectedChars = charEngBigs;
        break;
      case KeyboardType.engSmall:
        seletedKeyboardType = KeyboardType.engSmall;
        selectedChars = charEngSmalls;
        break;
      case KeyboardType.korA:
        seletedKeyboardType = KeyboardType.korA;
        selectedChars = charKorAs;
        break;
      case KeyboardType.korB:
        seletedKeyboardType = KeyboardType.korB;
        selectedChars = charKorBs;
        break;
      case KeyboardType.num:
        seletedKeyboardType = KeyboardType.num;
        selectedChars = charNums;
        break;
    }
    makeRows();
  }

  void makeRows() {
    firstRowKeys = selectedChars.getRange(0, 10).toList(); //0-9
    firstRowKeys = [...firstRowKeys, 'back'];
    //print(firstRowKeys);
    secondRowKeys = selectedChars.getRange(10, 19).toList();
    secondRowKeys = [...secondRowKeys, 'search'];
    //print(secondRowKeys);
    thirdRowKeys = selectedChars.getRange(19, 28).toList();
    thirdRowKeys = ['shift', ...thirdRowKeys];
    //print(thirdRowKeys);
    fourthRowKeys = ['num', 'engkor', 'space', 'reset', 'home'];
    //print(fourthRowKeys);
  }

  void setShift() {
    if (isPressedShift) {
      if (isPressedHangul) {
        setKeyboardType(KeyboardType.korB);
      } else {
        setKeyboardType(KeyboardType.engBig);
      }
    } else {
      if (isPressedHangul) {
        setKeyboardType(KeyboardType.korA);
      } else {
        setKeyboardType(KeyboardType.engSmall);
      }
    }

    setState(() {});
  }

  void setNumber() {
    if (isPressedNum) {
      setKeyboardType(KeyboardType.num);
    } else {
      if (isPressedHangul) {
        setKeyboardType(KeyboardType.korA);
      } else {
        setKeyboardType(KeyboardType.engSmall);
      }
    }
    setState(() {});
  }

  void setLanguage() {
    if (isPressedHangul) {
      setKeyboardType(KeyboardType.korA);
    } else {
      setKeyboardType(KeyboardType.engSmall);
    }
    setState(() {});
  }

  void keyPressed(String key, KeyType keyType) {
    //print('keyPressed key:$key keyType:$keyType');

    if (keyType == KeyType.normal) {
      combineChar(key);
      if (isPressedShift) {
        isPressedShift = false;
        setShift();
      }
    } else {
      if (key == "back") {
        combineChar('\b');
      }

      if (key == "shift") {
        isPressedShift = !isPressedShift;
        setShift();
      }
      if (key == "num") {
        isPressedNum = !isPressedNum;
        setNumber();
      }
      if (key == "engkor") {
        if (isPressedNum) {
          setLanguage();
        } else {
          isPressedHangul = !isPressedHangul;
          setLanguage();
        }

        isPressedShift = false;
        setShift();
        isPressedNum = false;
        setNumber();
      }
      if (key == "space") {
        combineChar(' ');
      }
      if (key == 'search') {
        widget.onSearch();
      }
      if (key == 'reset') {
        forceReset();
        widget.onReset();
      }
      if (key == 'home') {
        widget.onGoHome!();
      }
    }
    //결과
  }

  void combineChar(String ch) {
    if (deleteDebounce?.isActive ?? false) deleteDebounce?.cancel();
    deleteDebounce = Timer(const Duration(seconds: 2), () {
      deleteChar = false;
    });

    if (ch == '\b') {
      if (deleteChar) {
        input.backspace();
      } else {
        input.backspace();
      }
    } else {
      input.pushCharacter(ch);
      deleteChar = true;
    }

    widget.onOutput(input.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      //width: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...firstRowKeys
                  .map(
                    (char) => Key(
                        label: char,
                        keyType: char.length > 1
                            ? KeyType.functional
                            : KeyType.normal,
                        onKeyPressed: keyPressed,
                        isHangul: isPressedHangul,
                        isShift: isPressedShift,
                        isNum: isPressedNum),
                  )
                  .toList(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...secondRowKeys
                  .map((char) => Key(
                      label: char,
                      keyType:
                          char.length > 1 ? KeyType.functional : KeyType.normal,
                      onKeyPressed: keyPressed,
                      isHangul: isPressedHangul,
                      isShift: isPressedShift,
                      isNum: isPressedNum))
                  .toList(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...thirdRowKeys
                  .map((char) => Key(
                      label: char,
                      keyType:
                          char.length > 1 ? KeyType.functional : KeyType.normal,
                      onKeyPressed: keyPressed,
                      isHangul: isPressedHangul,
                      isShift: isPressedShift,
                      isNum: isPressedNum))
                  .toList(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...fourthRowKeys
                  .map((char) => Key(
                        label: char,
                        keyType: char.length > 1
                            ? KeyType.functional
                            : KeyType.normal,
                        onKeyPressed: keyPressed,
                        isHangul: isPressedHangul,
                        isShift: isPressedShift,
                        isNum: isPressedNum,
                      ))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}

enum KeyType {
  normal,
  functional,
}

class Key extends StatefulWidget {
  final String label;
  final KeyType keyType;
  final Function(String, KeyType) onKeyPressed;
  final bool isHangul;
  final bool isShift;
  final bool isNum;
  const Key({
    super.key,
    required this.label,
    this.keyType = KeyType.normal,
    required this.onKeyPressed,
    required this.isHangul,
    required this.isShift,
    required this.isNum,
  });

  @override
  State<Key> createState() => _KeyState();
}

class _KeyState extends State<Key> {
  Color buttonColor = Colors.white;

  @override
  void initState() {
    if (widget.label == 'search') {
      buttonColor = Color(0xFF103CBA);
    }
    if (widget.label == 'home') {
      buttonColor = Color(0xFF103CBA);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyWith = 70;
    if (widget.label == 'space') {
      keyWith = 430;
    }
    if (widget.label == 'num') {
      keyWith = 60;
    }
    if (widget.label == 'reset') {
      keyWith = 130;
    }
    if (widget.label == 'search') {
      keyWith = 130;
    }
    if (widget.label == 'home') {
      keyWith = 72;
    }

    return GestureDetector(
      onTap: () {
        widget.onKeyPressed(widget.label, widget.keyType);
      },
      onTapDown: (_) {
        setState(() {
          buttonColor = buttonColor.withOpacity(0.8);
        });
      },
      onTapUp: (_) {
        setState(() {
          buttonColor = buttonColor.withOpacity(1);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        width: keyWith,
        height: 70,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3))
            ]),
        child: Label(
          text: widget.label,
          isHangul: widget.isHangul,
          isNum: widget.isNum,
          isShift: widget.isShift,
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.text,
    required this.isHangul,
    required this.isShift,
    required this.isNum,
  });
  final String text;
  final bool isHangul;
  final bool isShift;
  final bool isNum;

  @override
  Widget build(BuildContext context) {
    if (text == 'space') {
      if (isHangul) {
        return const LabelText(text: '스페이스');
      } else {
        return const LabelText(text: 'space');
      }
    } else if (text == 'back') {
      return const IconText(icon: Icons.backspace_outlined);
    } else if (text == 'shift') {
      if (isShift) {
        return const ImageIconText(
          assetPath: 'assets/images/keyboard/keyboard_shift_icon_fill.png',
          color: const Color(0xFF103CBA),
        );
      } else {
        return const ImageIconText(
          assetPath: 'assets/images/keyboard/keyboard_shift_icon.png',
          color: const Color(0xFF103CBA),
        );
      }
    } else if (text == 'engkor') {
      return const IconText(icon: Icons.language_outlined);
    } else if (text == 'num') {
      if (isNum) {
        if (isHangul) {
          return const LabelText(
            text: '한글',
            fontSize: 18,
          );
        } else {
          return const LabelText(
            text: 'ABC',
            fontSize: 18,
          );
        }
      } else {
        return const LabelText(
          text: '123',
          fontSize: 18,
        );
      }
    } else if (text == 'reset') {
      if (isHangul) {
        return const LabelText(text: '초기화');
      } else {
        return const LabelText(text: 'RESET');
      }
    } else if (text == 'search') {
      if (isHangul) {
        return LabelText(
          text: '검색',
          color: Colors.white,
        );
      } else {
        return LabelText(
          text: 'SEARCH',
          color: Colors.white,
        );
      }
    } else if (text == 'home') {
      return const IconText(
        icon: Icons.home_rounded,
        color: Colors.white,
      );
    } else {
      return LabelText(text: text);
    }
  }
}

class LabelText extends StatelessWidget {
  const LabelText({
    super.key,
    required this.text,
    this.fontSize = 24,
    this.color = const Color(0xFF103CBA),
  });
  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final Color color;
  const IconText({
    super.key,
    required this.icon,
    this.color = const Color(0xFF103CBA),
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: 30,
    );
  }
}

class ImageIconText extends StatelessWidget {
  final String assetPath;
  final Color? color;
  const ImageIconText({
    super.key,
    required this.assetPath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(assetPath),
      size: 24,
      color: color,
    );
  }
}
