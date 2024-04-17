import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/scan_nfc_screen.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppConstant.size.width * 0.03),
      child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Logout Confirmation'),
                content: Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // No button pressed
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove("customer_id");
                      // Navigator.of(context).pop(true); // Yes button pressed
                      Get.off(ScanNFCScreen());
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.power_settings_new_outlined)),
    );
  }
}
