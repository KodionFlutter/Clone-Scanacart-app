import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Models/address_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/oder_success_widget.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
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

  var selectAddress = ''.obs;
  var addressList = <Data>[].obs;
  AddressModel addressModel = AddressModel();
  RxBool isLoading = false.obs;
  RxBool isOrder = false.obs;

  @override
  void onInit() {
    getAddressList();
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

    // You need to get the variants and decode to this ...
    Map<String, dynamic> sendVariantsData = {};
    var variants;
    Map<String, String> variantsMap = {};
    for (var items in cartItemsJson) {
      variants = items['variants'];
    }
    print("The variants all  :${variants}");
    //! Here i convert the data into sending form...

    if (variants != null) {
      String extractedData = variants.split('{')[1].split('}')[0];
      List<String> keyValuePairs = extractedData.split(', ');

      keyValuePairs.forEach((pair) {
        List<String> parts = pair.split('=');
        String key = parts[0].trim();
        String value = parts[1].replaceAll('"', '').trim();
        variantsMap[key] = value;
      });
    } else {
      // Handle the case where variants is null, for example:
      print('Variants is null');
      variantsMap = {};
    }

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
    isOrder.value = true;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int? customerId = preferences.getInt('customer_id');
      print("CustomerID :: ${customerId}");
      print("This is map : $mapData");
      var data = await APIServices.hitPlaceOrder(mapData);
      // showMessage("${data['message']}", AppColors.whiteBackgroundColor);
      showDialog(
          context: navigatorKey.currentState!.context,
          barrierDismissible: false,
          builder: (_) {
            return OrderSuccessWidget(
              customerId: customerId!,
              onPressed: () {
                Get.until((route) => route.isCurrent);
                Get.off(
                    FloatingButtonPage(customerId: customerId, state: true));
              },
            );
          });
      await DataBaseHelper.dataBaseHelper.deleteAllData();
      refreshItems();
      isOrder.value = false;
      // print("Shipping Response is : $data");
    } catch (e) {
      print("Exception is :: ${e.toString()}");
      message.value = e.toString().replaceAll('Exception:', '') ==
                  " You don't have enough points to place this order." ||
              e.toString().replaceAll('Exception:', '') ==
                  " You Are Not Eligible To Buy Products."
          ? e.toString().replaceAll('Exception:', '')
          : "Something went wrong";
    }
  }

// Lets here get the all saved Address ..

  Future getAddressList() async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = await preferences.getString("Token");
    var customerId = await preferences.getInt("customer_id");
    addressModel = await APIServices.hitAddressList(customerId, token);
    // addressList.clear();
    print("This is responseData of Address : ${addressModel.data!.length}");
    if (addressModel.success == true) {
      //! Here i bind the Data
      addressList.addAll(addressModel.data!);
    }
    isLoading.value = false;
    print("This is list Address name : ${addressList.length}");
  }
}
