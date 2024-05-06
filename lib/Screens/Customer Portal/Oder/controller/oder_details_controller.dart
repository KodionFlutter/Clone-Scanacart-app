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
  RxBool isLoaded = false.obs;

  //! onInit method
  @override
  void onInit() {
    getOrderDetails();
    print("OrderId : $oderId");
    super.onInit();
  }

  //! here ew calling getOderDetails Method

  Future getOrderDetails() async {
    orderDetailsModel = await APIServices.hitViewOrderDetails(oderId);
    orderDetailsDataList.clear();
    if (orderDetailsModel.success == true) {
      isLoaded.value = true;
      orderDetailsDataList.addAll(orderDetailsModel.data!);
    } else {
      isLoaded.value = false;
    }
  }

  //! Here we cancel the order ..

  Future cancelOrderProduct(Map<String, dynamic>? map) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    APIServices.hitCancelProduct(map, token);
  }

  //! AddNote method..

  Future addNotes(Map<String, dynamic> map) async {
    var data = APIServices.hitAddNotes(map );
    print("Data is $data");
  }
}
