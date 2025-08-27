import 'package:respeto/helpers/consts.dart';
import 'package:respeto/helpers/functions_helper.dart';

import '../../providers/dark_theme_provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key, required this.title, this.subtitle, this.withBack = false});
  final String title;
  final String? subtitle;
  final bool withBack;
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeConsumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: withBack
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: darkThemeConsumer.isDark
                      ? lightWihteColor
                      : blackTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (withBack)
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    color: darkThemeConsumer.isDark
                        ? lightWihteColor
                        : blackTextColor,
                    size: 24,
                  ),
                ),
            ],
          ),
          if (subtitle != null)
            const SizedBox(
              height: 20,
            ),
          if (subtitle != null)
            Text(
              subtitle.toString(),
              style: TextStyle(
                color: darkThemeConsumer.isDark
                    ? withOpacity(lightWihteColor, 0.9)
                    : withOpacity(blackTextColor, 0.9),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      );
    });
  }
}
