import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    controller!.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
            turns: _tween.animate(
                CurvedAnimation(parent: controller!, curve: Curves.elasticOut)),
            child: Image.asset("assets/shapes/carrotShape.png")),
      ),
    );
  }
}
