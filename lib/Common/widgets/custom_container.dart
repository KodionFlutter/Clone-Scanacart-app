import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height ;
  final double width;
  final double? radius;
  const CustomContainer({super.key, required this.height, required this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width:width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(radius!),
      ),
    );
  }
}
