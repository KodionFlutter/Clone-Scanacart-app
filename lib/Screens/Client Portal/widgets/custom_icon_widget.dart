import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class CustomIconWidget extends StatelessWidget {
  final double margin;
  final double padding;
  final IconData icon;
  final double iconSize;

  const CustomIconWidget(
      {super.key,
      required this.margin,
      required this.padding,
      required this.icon,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue),
      child: Icon(
        icon,
        size: iconSize,
        color: AppColors.whiteBackgroundColor,
      ),
    );
  }
}