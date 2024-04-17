import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/reward_screen.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVrifyController extends GetxController {
  final id;

  OTPVrifyController({required this.id});

  Rx<TextEditingController> otpVerifyController = TextEditingController().obs;

  //! Verify the OTP ..

  Future<void> verifyotp(otp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var data = await APIServices.verificationCode(otp, id.toString());
      print("verify data :: ${data}");
      if (data == true) {
        await prefs.setInt('customer_id', id);
        Get.off(RewardScreen(customerId: id));
      } else {
        Get.back();
      }
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }
}
