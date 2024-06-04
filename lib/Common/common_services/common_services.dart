import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

//! For showing a message .

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

List drawerMenuList = [
  // {
  //   "name": "AppHome",
  //   "icon": Icon(Icons.home_outlined, color: Colors.black),
  // },
  {
    "name": "Dashboard",
    "icon": Icon(Icons.dashboard_outlined, color: Colors.black),
  },
  {
    "name": "Orders",
    "icon": Icon(Icons.date_range, color: Colors.black),
  },
  {
    "name": "Client List",
    "icon": Icon(Icons.mail_outline, color: Colors.black),
  },
  {
    "name": "Maps",
    "icon": const Icon(Icons.share_location, color: Colors.black),
  },
  {
    "name": "Rewards",
    "icon": const Icon(Icons.card_giftcard, color: Colors.black),
  }
];

List subMenu = [
  {
    "name": "Products",
    "icon": const Icon(Icons.propane_tank_outlined, color: Colors.black),
  },
  {
    "name": "Orders",
    "icon": const Icon(Icons.shopping_cart_outlined, color: Colors.black),
  },
];