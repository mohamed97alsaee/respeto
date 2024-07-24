import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:respeto/helpers/consts.dart';

import '../../providers/dark_theme_provider.dart';

class SingleIntroScreen extends StatelessWidget {
  const SingleIntroScreen({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Container(
      width: size.width,
      color: themeListener.isDark ? primaryColor : lightWihteColor,
      // color: Colors.blue.withOpacity(0.2),
      // height: size.height * 0.62,
      child: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: themeListener.isDark
                          ? lightWihteColor
                          : Colors.black87),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Image.asset(
                image,
                width: size.width * 0.8,
                height: size.width * 0.8,
                fit: BoxFit.contain,
              ),

              SizedBox(
                height: size.height * 0.02,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 22),
              //   child: Text(
              //     description,
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.normal,
              //         color: themeListener.isDark
              //             ? primaryColor.withOpacity(0.7)
              //             : primaryColor.withOpacity(0.7)),
              //   ),
              // ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
