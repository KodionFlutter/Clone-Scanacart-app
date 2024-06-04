import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';

class ClientLoginController  extends GetxController{

  GlobalKey<FormState> globalFormKey =  GlobalKey<FormState>();
  var reg = RegExp(FormValidator.emailReg);
  RxBool isEnable = true.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;


}