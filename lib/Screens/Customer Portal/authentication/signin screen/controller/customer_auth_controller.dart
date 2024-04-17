import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Models/customer_signup_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/otp%20verify%20screen/otp_verify_screen.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerAuthController extends GetxController {
  Rx<TextEditingController> customerEmailController =
      TextEditingController().obs;
  Rx<TextEditingController> customerPhoneNumberController =
      TextEditingController().obs;

  @override
  void dispose() {
    customerEmailController.value.clear();
    customerEmailController.close();
    super.dispose();
  }

  // Customer Login and calljng the Service customerLogin method ..

  Future customerLogin(String email, String phone) async {
    CustomerSignUpModel customerSignUpModel = CustomerSignUpModel();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var customerData = await APIServices.customerLoginMethod(email, phone);
      customerSignUpModel = customerData;
      if (customerSignUpModel.success== true) {
        print("Login Customer Id :: ${customerSignUpModel.customerId}");
        print("object");
        Get.off(OtpVerifyScreen(
          id: customerSignUpModel.customerId!,
          email: customerEmailController.value,
        ));
        showMessage(
            "${customerSignUpModel.message}", AppColors.whiteBackgroundColor);
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
