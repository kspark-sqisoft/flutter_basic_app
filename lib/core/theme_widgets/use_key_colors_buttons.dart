import 'package:flutter/material.dart';

import '../theme_controller/theme_controller.dart';

class UseKeyColorsButtons extends StatelessWidget {
  const UseKeyColorsButtons({
    super.key,
    required this.controller,
  });
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = <bool>[
      controller.useKeyColors,
      controller.useSecondary && controller.useKeyColors,
      controller.useTertiary && controller.useKeyColors,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int index) {
        if (index == 0) {
          controller.setUseKeyColors(!controller.useKeyColors);
        }
        if (index == 1 && controller.useKeyColors) {
          controller.setUseSecondary(!controller.useSecondary);
        }
        if (index == 2 && controller.useKeyColors) {
          controller.setUseTertiary(!controller.useTertiary);
        }
      },
      children: <Widget>[
        const Tooltip(
          message: 'Use light theme Primary color\n'
              'as key color to seed your ColorScheme',
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Primary', style: TextStyle(fontSize: 12)),
          ),
        ),
        Visibility(
          visible: controller.useKeyColors,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: const Tooltip(
            message: 'Use light theme Secondary color\n'
                'as key color to seed your ColorScheme',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Secondary', style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
        Visibility(
          visible: controller.useKeyColors,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: const Tooltip(
            message: 'Use light theme Tertiary color\n'
                'as key color to seed your ColorScheme',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Tertiary', style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }
}
