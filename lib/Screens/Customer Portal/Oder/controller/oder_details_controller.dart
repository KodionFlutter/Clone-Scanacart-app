import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/order_details_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsController extends GetxController {
  final int oderId;

  OrderDetailsController({required this.oderId});

  //! Variable initialize
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();

  var orderDetailsDataList = <Data>[].obs;

  Rx<TextEditingController> addNoteController = TextEditingController().obs;
  Rx<TextEditingController> cancelNoteController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxString isCancel = ''.obs;
  RxBool isCalled = false.obs;

  //! onInit method

  @override
  void onInit() {
    getOrderDetails();
    super.onInit();
  }

  //! here ew calling getOderDetails Method

  Future getOrderDetails() async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // int? oderId = preferences.getInt("oderId");
    // print("oderId : $oderId");
    orderDetailsModel = await APIServices.hitViewOrderDetails(oderId);
    orderDetailsDataList.clear();
    if (orderDetailsModel.success == true) {
      orderDetailsDataList.addAll(orderDetailsModel.data!);
      isCancel.value = orderDetailsModel.data![0].orderStatus!;
    }
    isLoading.value = false;
  }

  //! Here we cancel the order ..

  Future cancelOrderProduct(Map<String, dynamic>? map) async {
    isLoading.value = true;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("Token");
      APIServices.hitCancelProduct(map, token);
      // preferences.remove("oderId");
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      return "exception :${e.toString()}";
    }
  }

  //! AddNote method..

  Future addNotes(Map<String, dynamic> map) async {
    isCalled.value = true;
    try {
      var data = APIServices.hitAddNotes(map);
      print("Data is $data");
      isCalled.value = false;
    } catch (e) {
      isCalled.value = false;
      return "exception : ${e.toString()}";
    }
  }

  void updateButtonState() {
    isLoading.value = true;
  }

  // Method to reset the button state
  void resetButtonState() {
    isLoading.value = false;
  }

  Future backMethod() async {}
}
