import 'package:flutter/material.dart';

class ResturantScreen extends StatefulWidget {
  const ResturantScreen({super.key});

  @override
  State<ResturantScreen> createState() => _ResturantScreenState();
}

class _ResturantScreenState extends State<ResturantScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("ResturantScreen"),
      ),
    );
  }
}
