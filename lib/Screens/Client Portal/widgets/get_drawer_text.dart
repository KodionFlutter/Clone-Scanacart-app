import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class GetDrawerText extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const GetDrawerText(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: AppColors.txtScanProductColor.withOpacity(0.2),
        onTap: onTap,
        child: ListTile(
          title: Text(
            "$title ",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          leading: icon,
        ),
      ),
    );
  }
}