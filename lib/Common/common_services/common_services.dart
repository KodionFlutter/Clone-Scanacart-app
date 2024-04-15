import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

void showMessage(String message, Color color) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        message.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.txtBlackColor),
      ),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}