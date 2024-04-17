import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Base%20service/services.dart';
import 'package:scan_cart_clone/Customer%20Portal/reward%20screen/reward_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVrifyController extends GetxController {
  Rx<TextEditingController> otpVerifyController = TextEditingController().obs;

  //! Verify the OTP ..

  Future<void> verifyotp(otp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("customer_id");
    print("This is customer id :: ${id}");
    try {
      var data = await APIServices.verificationCode(otp, id.toString());
      print("Comminf verify data :: ${data}");
      if (data == true) {
        Get.off(RewardScreen());
      } else {
        Get.back();
      }
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }
}
