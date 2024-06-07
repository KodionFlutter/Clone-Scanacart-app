import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  final String title;
  final double size;
  var fontWeight;
  final Color color;

  CommonTextWidget(
      {super.key,
      required this.title,
      required this.size,
      this.fontWeight,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color));
  }
}