import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CustomerAuthController extends GetxController {
  Rx<TextEditingController> customerEmailController =
      TextEditingController().obs;
  Rx<TextEditingController> customerPhoneNumberController =
      TextEditingController().obs;
}
