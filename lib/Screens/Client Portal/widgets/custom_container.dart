import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class CustomContainerWidget extends StatelessWidget {
  var margin;
  var padding;
  final Widget child;

  CustomContainerWidget(
      {super.key, required this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin ?? 10),
      padding: EdgeInsets.all(padding ?? 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            // BoxShadow(
            //   color: Colors.black12,
            //   blurRadius: 1.0,
            //   offset: Offset(-2, -2),
            // ),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(4, 4),
                spreadRadius: 1.0),
          ],
          color: AppColors.whiteBackgroundColor),
      child: child,
    );
  }
}