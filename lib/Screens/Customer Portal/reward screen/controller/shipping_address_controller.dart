import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
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
  var sendOrderData;
  var productSendVariants;
  List storeData = [];
  List addData = [];

  @override
  void onInit() {
    refreshItems();
    super.onInit();
  }

  //! Here fetch the cart Item ..
  Future refreshItems() async {
    //! Getting the Local DataBase
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? customerId = preferences.getInt('customer_id');
    print("CustomerID :: ${customerId}");

    //! Getting the Data From The DataBase ..
    cartItemsJson = await DataBaseHelper.dataBaseHelper.fetchProduct();
    storeData = await DataBaseHelper.dataBaseHelper.fetchProduct();
    print('CartItem :=>> ${cartItemsJson}');
    // sendOrderData = jsonEncode(cartItemsJson);
    // print("000 : $sendOrderData");

    // You need to get the variants and decode to this ...
    Map<String, dynamic> sendVariantsData = {};
    var variants;
    Map<String, String> variantsMap = {};
    for (var items in cartItemsJson) {
      variants = items['variants'];
    }

    print("The variants all  :${variants}");
    //! Here i convert the data into sending form...

    String extractedData = variants.split('{')[1].split('}')[0];
    List<String> keyValuePairs = extractedData.split(', ');

    keyValuePairs.forEach((pair) {
      List<String> parts = pair.split('=');
      String key = parts[0].trim();
      String value = parts[1].replaceAll('"', '').trim();
      variantsMap[key] = value;
    });

    var endciesendVariantsData = sendVariantsData;
    for (var items in cartItemsJson) {
      sendVariantsData["id"] = items["id"];
      sendVariantsData["client_id"] = items["client_id"];
      sendVariantsData["productId"] = items["productId"];
      sendVariantsData["quantity"] = items["quantity"];
      sendVariantsData["points"] = items["points"];
      sendVariantsData["variantId"] = items["variantId"];
      sendVariantsData["category_id"] = items["category_id"];
      sendVariantsData["productName"] = items["productName"];
      sendVariantsData["imageURL"] = items["imageURL"];
      sendVariantsData['variants'] = variantsMap;
      productSendVariants = jsonEncode(endciesendVariantsData);
      addData.add(productSendVariants);
    }
    print("This is all Addded data into the map : $addData");
    print("variantsMap : $productSendVariants");
  }

  //! Make here function for adding the shipping or order....
  Future productShipping(Map<String, dynamic> mapData) async {
    try {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      print("This is map : $mapData");
      var data = await APIServices.hitPlaceOrder(mapData);
      showMessage("${data['message']}", AppColors.whiteBackgroundColor);
      await DataBaseHelper.dataBaseHelper.deleteAllData();
      refreshItems();
      // print("Shipping Response is : $data");
    } catch (e) {
      print("Exception is :: ${e.toString()}");
      message.value = "You Are Not Eligible To Buy Products.";
    }
  }
}
