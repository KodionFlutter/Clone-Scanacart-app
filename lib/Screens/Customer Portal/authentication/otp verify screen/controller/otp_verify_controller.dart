import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/reward_screen.dart';
import 'package:scan_cart_clone/Screens/nfc%20loading/nfc_loading.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVrifyController extends GetxController {
  final id;

  OTPVrifyController({required this.id});

  Rx<TextEditingController> otpVerifyController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isShowingAnimationScreen = false.obs;
  var context = navigatorKey.currentState!.context;

  showLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return NfcLoadingScreen();
      },
    );
  }

  //Hide Loading Screen
  hideLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = false;
    Get.back();
  }

  //! Verify the OTP ..

  Future<void> verifyotp(otp) async {
    showLoadingScreen(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var data = await APIServices.verificationCode(otp, id.toString());
      print("verify data :: ${data}");
      if (data == true) {
        await prefs.setInt('customer_id', id);
        hideLoadingScreen(context);
        Get.off(FloatingButtonPage(customerId: id , state: true,));
        otpVerifyController.value.clear();
      } else {
        Get.back();
      }
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }
}
