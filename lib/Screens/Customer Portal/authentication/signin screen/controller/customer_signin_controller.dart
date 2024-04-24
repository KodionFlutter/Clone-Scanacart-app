import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Models/customer_signup_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/otp%20verify%20screen/otp_verify_screen.dart';
import 'package:scan_cart_clone/Screens/nfc%20loading/nfc_loading.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CustomerAuthController extends GetxController {
  //! Variable Declaration
  Rx<TextEditingController> customerEmailController =
      TextEditingController().obs;
  Rx<TextEditingController> customerPhoneNumberController =
      TextEditingController().obs;
  RxBool isShowingAnimationScreen = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var reg = RegExp(FormValidator.emailReg);
  RxBool isEnable = true.obs;

  @override
  void dispose() {
    customerEmailController.value.clear();
    customerPhoneNumberController.value.clear();
    customerPhoneNumberController.value.dispose();
    customerEmailController.value.dispose();
    super.dispose();
  }

  //  Show Loading screen
  showLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = true;
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentState!.context,
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

  // Customer Login and calling the Service customerLogin method ..
  Future customerLogin(String email, String phone) async {
    CustomerSignUpModel customerSignUpModel = CustomerSignUpModel();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      showLoadingScreen(navigatorKey.currentState!.context);
      var customerData = await APIServices.customerLoginMethod(email, phone);
      customerSignUpModel = customerData;
      if (customerSignUpModel.success == true) {
        print("Login Customer Id :: ${customerSignUpModel.customerId}");

        //! Make the field empty
        customerPhoneNumberController.value.clear();
        customerEmailController.value.clear();
        hideLoadingScreen(navigatorKey.currentState!.context);
        // Go to OTp Verify Page
        showMessage(
            "${customerSignUpModel.message}", AppColors.whiteBackgroundColor);
        Get.off(OtpVerifyScreen(
          id: customerSignUpModel.customerId!,
          email: customerEmailController.value,
        ));
      } else {
        showMessage(
            "${customerSignUpModel.message}", AppColors.whiteBackgroundColor);
        Get.back();
        print("No");
      }
      log("Customer login data :: ${customerData}");
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }
}
