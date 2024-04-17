import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Models/customer_signup_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/otp%20verify%20screen/otp_verify_screen.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class CustomerSignupController extends GetxController {
  Rx<TextEditingController> customerNameController =
      TextEditingController().obs;
  Rx<TextEditingController> customerEmailController =
      TextEditingController().obs;
  Rx<TextEditingController> customerPhoneController =
      TextEditingController().obs;

  final formKey = GlobalKey<FormState>();

  //! Here we make a signUp

  Future signUPCustomer(Map<String, dynamic> map) async {
    CustomerSignUpModel customerSignUpModel = CustomerSignUpModel();
    try {
      var customerData = await APIServices.customerSignUP(map);
      customerSignUpModel = customerData;
      if (customerSignUpModel.success == true) {
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
      log("Customer SignUP d :: ${customerData}");
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }
}
