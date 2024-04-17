import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:scan_cart_clone/Base%20service/services.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerAuthController extends GetxController {
  Rx<TextEditingController> customerEmailController =
      TextEditingController().obs;
  Rx<TextEditingController> customerPhoneNumberController =
      TextEditingController().obs;

  // Customer Login and calljng the Service customerLogin method ..

  Future customerLogin(String email, String phone) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // final token = prefs.getString("Token").toString();
      // print("Customer token :: ${token}");
      var customerData = await APIServices.customerLoginMethod(email, phone);
      if(customerData["success"] == true){
        print("object");
        showMessage("${customerData["message"]}",AppColors.whiteBackgroundColor);
      }else{
        print("No");
      }
      log("Customer login d :: ${customerData}");
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }
}
