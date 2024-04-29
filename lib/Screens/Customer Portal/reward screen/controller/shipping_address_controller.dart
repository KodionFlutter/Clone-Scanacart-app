import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';

class ShippingAddressController extends GetxController {
  //!
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> stateController = TextEditingController().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;

  var reg = RegExp(FormValidator.nameReg);
  var regEmail = RegExp(FormValidator.emailReg);

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }


  //! Make here function for adding the shipping or order....




}
