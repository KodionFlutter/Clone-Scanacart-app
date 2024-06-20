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

class CustomerSignupController extends GetxController {
  Rx<TextEditingController> customerNameController =
      TextEditingController().obs;
  Rx<TextEditingController> customerEmailController =
      TextEditingController().obs;
  Rx<TextEditingController> customerPhoneController =
      TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
  var reg = RegExp(FormValidator.emailReg);
  RxBool isShowingAnimationScreen = false.obs;
  var context = navigatorKey.currentState!.context;
  CustomerSignUpModel customerSignUpModel = CustomerSignUpModel();

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

  //! Here we make a signUp

  Future signUPCustomer(Map<String, dynamic> map) async {
    try {
      showLoadingScreen(context);
      var customerData = await APIServices.customerSignUP(map);
      customerSignUpModel = customerData;
      if (customerSignUpModel.success == true) {
        print("Login success :: true");

        if (customerSignUpModel.message == "User already exist.") {
          showMessage("User already exist.", AppColors.txtWhiteColor);
          hideLoadingScreen(context);
        } else {
          hideLoadingScreen(context);
          Get.off(OtpVerifyScreen(
            id: customerSignUpModel.customerId!,
            email: customerEmailController.value,
          ));
          customerEmailController.value.clear();
          customerNameController.value.clear();
          customerPhoneController.value.clear();

          showMessage(
              "${customerSignUpModel.message}", AppColors.whiteBackgroundColor);
        }
      } else {
        showMessage(
            "${customerSignUpModel.message}", AppColors.whiteBackgroundColor);
        Get.back();
        print("No");
      }
      log("Customer SignUP d :: $customerData");
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }
}
