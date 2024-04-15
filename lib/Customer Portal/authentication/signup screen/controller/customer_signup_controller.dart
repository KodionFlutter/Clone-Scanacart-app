import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Base%20service/services.dart';

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
    try {
      await APIServices.customerSignUP(map);
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }
}
