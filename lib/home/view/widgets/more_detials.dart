import 'package:flutter/material.dart';
import 'package:weather_app/common/style/sized_box.dart';

class MoreDetialsWidgets extends StatelessWidget {
  const MoreDetialsWidgets({
    super.key,
    required this.title,
    required this.text,
    this.color = Colors.white,
  });
  final String title;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white30,
            fontWeight: FontWeight.bold,
          ),
        ),
        KSizedBox().height5,
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
