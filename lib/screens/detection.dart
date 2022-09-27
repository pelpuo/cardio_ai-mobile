import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';

class Detection extends StatefulWidget {
  const Detection({Key? key}) : super(key: key);

  @override
  State<Detection> createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Detection and Classification"),
      ),
    );
  }
}
