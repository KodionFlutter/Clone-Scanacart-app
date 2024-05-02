import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

  @override
  void onInit() {
    refreshItems();
    super.onInit();
  }

  //! Here fetch the cart Item ..
  Future refreshItems() async {
    // cartItemsJson = await DataBaseHelper.dataBaseHelper.fetchProduct();
    // print('CartItem :=>> ${cartItemsJson}');
    // sendOrderData = jsonEncode(cartItemsJson);
    // print("000 : $sendOrderData");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var token = preferences.getString("Token");
    // print("shipping main Token :: $token");
    // int? customerId = preferences.getInt('customer_id');
    // print("Cus :: ${customerId}");
    // List<Map<String, dynamic>> originalData = json.decode(cartItemsJson);
    //
    // // Modify the data
    // List<Map<String, dynamic>> modifiedData = originalData.map((item) {
    //   // Replace the "variants" value with an empty object
    //   item['variants'] = {};
    //   return item;
    // }).toList();
    //
    // // Convert the modified data back to JSON string
    // String modifiedJsonData = json.encode(modifiedData);
    //
    // print("modifiedJsonData : $modifiedJsonData");

    cartItemsJson = await DataBaseHelper.dataBaseHelper.fetchProduct();

// Assuming cartItemsJson is a list of items retrieved from the database
    List<Map<String, dynamic>> itemList = [];

// Iterate over each item in cartItemsJson and add it to itemList
    for (var item in cartItemsJson) {
      itemList.add(item); // toJson() method is just an example, use the actual method to convert your item to a map
    }

// Modify the data
    List<Map<String, dynamic>> modifiedData = itemList.map((item) {
      // Replace the "variants" value with an empty object
      item['variants'] = {};
      return item;
    }).toList();

// Convert the modified data back to JSON string
    String modifiedJsonData = json.encode(modifiedData);

    print("modifiedJsonData : $modifiedJsonData");

    // if (sendOrderData != null) {
    //   List<dynamic> decodedList = jsonDecode(sendOrderData);
    //   print("decodedList :: $decodedList");
    //   List<Map<String, dynamic>> retrievedCartItems =
    //       decodedList.map((item) => Map<String, dynamic>.from(item)).toList();
    //   cartItems.clear(); // Clear existing items
    //   cartItems.addAll(retrievedCartItems);
    //   print("Is this cartItem :: ${cartItems}");
    // }else{
    //   print("Not workinh");
    // }
    // update();
  }

  //! Make here function for adding the shipping or order....
  Future productShipping() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // String vari = jsonEncode(sendOrderData);
      print("Vari :: $sendOrderData");
      // var token = preferences.getString("Token");
      // print("shipping main Token :: $token");
      Map<String, dynamic> mapData = {};
      mapData['name'] = "demo";
      mapData['email'] = "demo@gmail.com";
      mapData['phone'] = "9616277301";
      mapData['address'] = "BEstech";
      mapData['city'] = "mohali";
      mapData['state'] = "punjab";
      mapData['street'] = "Bu 12";
      mapData['zipcode'] = "12345";
      mapData['customer_id'] = "112258";
      mapData['total_points'] = "25";
      mapData['client_id'] = "1910";
      mapData['cart_Items'] = sendOrderData;
      mapData['save_address'] = "0";
      mapData['shipping_id'] = "";

      //   "name": "demo",
      //   "email": "demo@gmail.com",
      //   "phone": "",
      //   "address": "Bestech",
      //   "city": "mohali",
      //   "state": "panjab",
      //   "street": "panjab",
      //   "zipcode": "12345",
      //   "customer_id": "112258",
      //   "total_points": "25",
      //   "client_id": "1910",
      //   "cart_Items": [
      //     {
      //       "quantity": "1",
      //       "imageURL": "https://dev.scanacart.com/admin/products/assets/product/images/amex-giftcard.png__1069x690_q85_subsampling-2_720.png",
      //       "variants": {},
      //       "variantId": "0",
      //       "productId": "205",
      //       "productName": "gift card 1",
      //       "points": "25",
      //       "client_id": "1910",
      //       "category_id": "60"
      //     }
      //   ],
      //   "save_address": "0",
      //   "shipping_id": ""
      // };
      //! We need to get
      // cartItems.value = jsonEncode(cartItemsJson) as RxList;
      // print("Cart Items Json => $cartItems");
      print("This is map : $mapData");
      var data = await APIServices.hitPlaceOrder(mapData);
      print("Shipping Response is : $data");
    } catch (e) {
      print("Exception is :: ${e.toString()}");
      message.value = "You Are Not Eligible To Buy Products.";
    }
  }
}
