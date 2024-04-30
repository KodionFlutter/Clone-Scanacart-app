import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  RxBool select = false.obs;
 var cartItems = [].obs;
 var cartItemsJson;
 RxString message = ''.obs;

  @override
  void onInit() {
    // productShipping();
    super.onInit();
  }

  //! Make here function for adding the shipping or order....
  Future productShipping(map) async {
    //! We need to get
   try{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     var token = preferences.getString("Token");
     print("shipping main Token :: $token");
     cartItemsJson = jsonEncode(cartItems);
     print("=> $cartItemsJson");
     var data = await APIServices.productPlaceOrder(map, token);
     print("Data :: is :: $data");
   }catch(e){
     print("Exception is :: ${e.toString()}");
     message.value = "You Are Not Eligible To Buy Products.";
   }
  }
}
