import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/common_model.dart';
import 'package:scan_cart_clone/Models/order_details_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsController extends GetxController {
  final int oderId;

  OrderDetailsController({required this.oderId});

  //! Variable initialize
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();

  var orderDetailsDataList = <Data>[].obs;
  var orderItemList = <Orderitem>[].obs;

  Rx<TextEditingController> addNoteController = TextEditingController().obs;
  Rx<TextEditingController> cancelNoteController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxString isCancel = ''.obs;
  RxBool isCalled = false.obs;
  CommonModel commonModel = CommonModel();

  //! onInit method

  @override
  void onInit() {
    getOrderDetails();
    super.onInit();
  }

  //! here ew calling getOderDetails Method

  Future getOrderDetails() async {
    isLoading.value = true;
    // int? oderId = preferences.getInt("oderId");
    // print("oderId : $oderId");
    orderDetailsModel = await APIServices.hitViewOrderDetails(oderId);
    orderDetailsDataList.clear();
    if (orderDetailsModel.success == true) {
      orderDetailsDataList.addAll(orderDetailsModel.data!);
      if (kDebugMode) {
        print("This is all data Coming : ${orderDetailsDataList[0].orderitem![0].quantity}");
      }
      // orderItemList.addAll(orderDetailsModel.data![0].orderitem!);
      isCancel.value = orderDetailsModel.data![0].orderStatus!;
      if (kDebugMode) {
        print("This is the orderItem List : $orderItemList");
      }
    }
    isLoading.value = false;
  }

  //! Here we cancel the order ..

  Future cancelOrderProduct(Map<String, dynamic>? map) async {
    isCalled.value = true;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("Token");
      commonModel = await APIServices.hitCancelProduct(map, token);
      if (kDebugMode) {
        print("This is cancel response : ${commonModel.message.toString()}");
      }
      getOrderDetails();
      Get.back();
      isCalled.value = false;
    } catch (e) {
      isCalled.value = false;
      return "exception :${e.toString()}";
    }
  }

  //! AddNote method..

  Future addNotes(Map<String, dynamic> map) async {
    try {
      isCalled.value = true;
      commonModel = await APIServices.hitAddNotes(map);
      if (kDebugMode) {
        print("Message of response : ${commonModel.message.toString()}");
      }
      getOrderDetails();
      Get.back();
      isCalled.value = false;
    } catch (e) {
      isCalled.value = false;
      return "exception : ${e.toString()}";
    }
  }
}
