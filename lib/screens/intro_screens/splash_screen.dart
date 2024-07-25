import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:respeto/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    controller!.repeat(reverse: true);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const ScreenRouter()),
          (route) => false);
    });
  }

  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            ScaleTransition(
              scale: _tween.animate(CurvedAnimation(
                  parent: controller!, curve: Curves.elasticOut)),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/shapes/carrotShape.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
