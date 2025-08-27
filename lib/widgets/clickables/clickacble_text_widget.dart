import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/dark_theme_provider.dart';
import '../../helpers/consts.dart';
import '../../helpers/functions_helper.dart';

class ClickableText extends StatefulWidget {
  const ClickableText({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 14,
    this.color = primaryColor,
    this.useColors = false,
    this.enabled = true,
    this.withUnderline = false,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color color;
  final bool useColors;
  final bool enabled;
  final bool withUnderline;

  @override
  State<ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          if (widget.enabled) widget.onPressed();
        },
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
              color: themeListener.isDark && !widget.useColors
                  ? withOpacity(lightWihteColor, widget.enabled ? 1 : 0.3)
                  : widget.color,
              decoration:
                  widget.withUnderline ? TextDecoration.underline : null),
        ),
      ),
    );
  }
}
