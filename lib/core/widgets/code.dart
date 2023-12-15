import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
  Code('''
  void main() async {
    runApp(const MyApp());
  }
''')
 */

class Code extends StatelessWidget {
  final String text;
  final String? title;
  final Color? titleColor;
  final Color? bgColor;
  const Code(this.text, {super.key, this.title, this.bgColor, this.titleColor});

  static Color defaultBgColor = Colors.grey.withOpacity(0.2);
  static Color defaultTitleColor = Colors.red.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isDark = colorScheme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      color: bgColor ?? defaultBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title.toString(),
                  style: TextStyle(
                      color: titleColor ?? defaultTitleColor,
                      fontWeight: FontWeight.bold),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            text,
            enableInteractiveSelection: true,
            contextMenuBuilder: (context, editableTextState) {
              return AdaptiveTextSelectionToolbar(
                anchors: editableTextState.contextMenuAnchors,
                children: editableTextState.contextMenuButtonItems
                    .map((ContextMenuButtonItem buttonItem) {
                  return CupertinoButton(
                    borderRadius: null,
                    color: const Color(0xffaaaa00),
                    disabledColor: const Color(0xffaaaaff),
                    onPressed: buttonItem.onPressed,
                    padding: const EdgeInsets.all(10.0),
                    pressedOpacity: 0.7,
                    child: SizedBox(
                      width: 200.0,
                      child: Text(
                        CupertinoTextSelectionToolbarButton.getButtonLabel(
                            context, buttonItem),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            style: TextStyle(
                color: isDark
                    ? Colors.white.withOpacity(0.8)
                    : Colors.black.withOpacity(0.8),
                fontSize: 14),
          )
        ],
      ),
    );
  }
}
