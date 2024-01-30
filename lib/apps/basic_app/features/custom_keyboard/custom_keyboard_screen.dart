import 'package:flutter/material.dart';

import 'keyboard.dart';

enum InputMode { name, keyword, date }

class CustomKeyboardScreen extends StatefulWidget {
  const CustomKeyboardScreen({super.key});

  @override
  State<CustomKeyboardScreen> createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  late FocusNode nameFocusNode;
  late FocusNode keywordFocusNode;

  late TextEditingController nameTextEditingController;
  late TextEditingController keywordTextEditingController;

  TextEditingController? selectTextEditingController;
  String? _name;
  String? _keyword;
  late GlobalKey<FormState> formKey;
  InputMode inputMode = InputMode.name;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    nameFocusNode = FocusNode();
    keywordFocusNode = FocusNode();

    nameFocusNode.addListener(() {
      if (nameFocusNode.hasFocus) {
        inputMode = InputMode.name;
        selectTextEditingController = nameTextEditingController;
        //keyboard didUpdateWidget
        setState(() {});
      }
    });
    keywordFocusNode.addListener(() {
      if (keywordFocusNode.hasFocus) {
        inputMode = InputMode.keyword;
        selectTextEditingController = keywordTextEditingController;
        setState(() {});
      }
    });

    nameTextEditingController = TextEditingController();
    keywordTextEditingController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      inputMode = InputMode.name;
      selectTextEditingController = nameTextEditingController;
      FocusScope.of(context).requestFocus(nameFocusNode);
    });

    super.initState();
  }

  void onOutput(String out) {
    print('onOutput $out');
    if (selectTextEditingController == null) return;
    selectTextEditingController!.text = out;
    selectTextEditingController!.selection = TextSelection.fromPosition(
        TextPosition(offset: selectTextEditingController!.text.length));
  }

  void onSearch() {
    print('onSearch');
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  void onReset() {
    if (selectTextEditingController == null) return;
    selectTextEditingController!.text = '';
  }

  void onGoHome() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Hangul Keyboard')),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              //이름 검색
              SizedBox(
                width: 630,
                child: TextFormField(
                  controller: nameTextEditingController,
                  focusNode: nameFocusNode,
                  onSaved: (String? name) {
                    setState(() {
                      _name = name as String;
                    });
                  },
                  validator: (String? name) {
                    if (name == null || name.isEmpty) {
                      return '이름을 입력해 주세요';
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: 'ex) 홍길동',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //키워드 검색
              SizedBox(
                width: 860,
                child: TextFormField(
                  controller: keywordTextEditingController,
                  focusNode: keywordFocusNode,
                  onSaved: (String? keyword) {
                    setState(() {
                      _keyword = keyword as String;
                    });
                  },
                  validator: (String? keyword) {
                    if (keyword == null || keyword.isEmpty) {
                      return '검색어를 입력해 주세요';
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: 'ex) 60주년',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Focus(
          descendantsAreFocusable: false,
          canRequestFocus: false,
          child: Keyboard(
            onOutput: onOutput,
            onSearch: onSearch,
            onReset: onReset,
            onGoHome: onGoHome,
            inputMode: inputMode,
            textEditingController: selectTextEditingController,
          ),
        )
      ]),
    );
  }
}
