import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/order_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/reward_screen.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/scan_nfc_screen.dart';

class FloatingBarController extends GetxController {
  final int customerId;
  bool? state;

  FloatingBarController({required this.customerId, this.state});

  //! Make a List for The Page ..
  List<Widget> pagesList = [];
  RxInt selectedIndex = 1.obs;

  void onCheckIndex(int index) {
    if (index == 0) {
      if (state == false) {
        print("Go main page");
        Get.offAll(ScanNFCScreen());
      } else if (state == true) {
        print("Go back ");
        Get.back();
      }
    } else {
      selectedIndex.value = index;
    }
  }

  @override
  void onInit() {
    pagesList.addAll([
      ScanNFCScreen(),
      RewardScreen(customerId: customerId),
      OrderPage(),
    ]);

    // pagesList.add(Container());
    super.onInit();
  }
}
