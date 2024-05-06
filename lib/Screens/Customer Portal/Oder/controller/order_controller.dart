import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/order_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  OrderModel orderModel = OrderModel();
  var orderDataList = <Data>[].obs;
  var status = 'All'.obs;

  @override
  void onInit() {
    getAllOrderProduct();
    super.onInit();
  }

  Future getAllOrderProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? customerId = preferences.getInt('customer_id');
    orderModel = await APIServices.hitOrderList(customerId, status.value);
    // print("This is getResponse length : ${orderModel.data!.length}");
    orderDataList.clear();
    if (orderModel.success == true) {
      orderDataList.addAll(orderModel.data!);
    }
  }

  //! Get the order Status color ..

  getStatusColor(oderStatus) {
    switch (oderStatus) {
      case "Pending":
        return Colors.yellowAccent;
      case "InProgress":
        return Colors.blue;
      case "Cancel":
        return Colors.red;
      case "Fulfilled":
        return Colors.green;
    }
  }
}
