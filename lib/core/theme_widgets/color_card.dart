import 'dart:async';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../theme_const/app.dart';
import 'copy_color_to_clipboard.dart';

class ColorCard extends StatefulWidget {
  const ColorCard({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.shadowColor,
    this.size,
    this.elevation,
  });

  final String label;
  final Color color;
  final Color textColor;
  final Color? shadowColor;
  final Size? size;

  /// Default to 0 if not provided.
  final double? elevation;

  @override
  State<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
  late String materialName;
  late String nameThatColor;
  late String space;
  late String hexCode;

  // The nameThatColor and materialName lookups are expensive, especially
  // nameThatColor. Widget stores them as stateful values to avoid computing
  // them every time the widget rebuilds.
  @override
  void initState() {
    super.initState();
    materialName = ColorTools.materialName(widget.color);
    nameThatColor = ColorTools.nameThatColor(widget.color);
    space = materialName == '' ? '' : ' ';
    hexCode = widget.color.hexCode;
  }

  @override
  void didUpdateWidget(covariant ColorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color) {
      materialName = ColorTools.materialName(widget.color);
      nameThatColor = ColorTools.nameThatColor(widget.color);
      space = materialName == '' ? '' : ' ';
      hexCode = widget.color.hexCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.sizeOf(context);
    final bool isPhone = mediaSize.width < App.phoneWidthBreakpoint ||
        mediaSize.height < App.phoneHeightBreakpoint;
    final double fontSize = isPhone ? 10 : 11;
    final Size effectiveSize =
        widget.size ?? (isPhone ? const Size(74, 54) : const Size(86, 58));

    final String hexCode = widget.color.hexCode;

    return RepaintBoundary(
      child: SizedBox(
        width: effectiveSize.width,
        height: effectiveSize.height,
        child: Tooltip(
          waitDuration: const Duration(milliseconds: 700),
          message: 'Color #$hexCode $nameThatColor$space$materialName.'
              '\nTap to copy color to Clipboard.',
          child: Card(
            elevation: widget.elevation ?? 0,
            surfaceTintColor: Colors.transparent,
            shadowColor: widget.shadowColor,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            color: widget.color,
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                unawaited(copyColorToClipboard(context, widget.color));
              },
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(color: widget.textColor, fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
