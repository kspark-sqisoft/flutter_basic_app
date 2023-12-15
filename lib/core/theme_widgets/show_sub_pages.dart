import 'package:flutter/material.dart';

import '../theme_controller/theme_controller.dart';
import 'page_examples.dart';
import 'stateful_header_card.dart';

class ShowSubPages extends StatelessWidget {
  const ShowSubPages({this.controller, super.key});

  final ThemeController? controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color iconColor = isLight
        ? Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x99),
            theme.colorScheme.onBackground)
        : Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x7F),
            theme.colorScheme.onBackground);
    return StatefulHeaderCard(
      leading: Icon(Icons.article_outlined, color: iconColor),
      title: const Text('Page Examples'),
      child: PageExamples(controller: controller),
    );
  }
}
