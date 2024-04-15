import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVrifyController extends GetxController {
  Rx<TextEditingController> otpVerifyController = TextEditingController().obs;

  //! Verify the OTP ..

  Future<void> verifyotp(otp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id =prefs.getString("customer_id");
    print("This is customer id :: ${id}");
    try {
      await APIServices.verificationCode(otp, id.toString());
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }
}
