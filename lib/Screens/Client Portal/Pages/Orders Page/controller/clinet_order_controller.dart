import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:scan_cart_clone/Utils/Base%20service/dio_client.dart';
import 'package:scan_cart_clone/Utils/Base%20service/exception_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientOrdersController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> addCommentController = TextEditingController().obs;

  var trackingList = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // fetchTopCities();
    fetchClientOrder();
    super.onInit();
  }

  //! Here I get the Order API and handle them..
  // Future<void> fetchTopCities() async {
  //   isLoading(true);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("admin_token");
  //   int? clientID = prefs.getInt("client_id");
  //   DioService dioService = DioService(
  //     baseUrl: "${ApiServiceConfig.apiBaseUrl}",
  //     clientId: "$clientID",
  //     token: "$token",
  //   );
  //   try {
  //     final response = await dioService.getTopUSStates();
  //     topCities.assignAll(response.data['topUSStates']);
  //     print("topUSStates ::6376376 ${topCities}");
  //     errorMessage('');
  //   } catch (e) {
  //     errorMessage(e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  //! getting the Client Order List ..

  Future<void> fetchClientOrder() async {
    isLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    DioService dioService = DioService(
      baseUrl: "${ApiServiceConfig.apiBaseUrl}",
      clientId: "$clientID",
      token: "$token",
    );
    try {
      final response = await dioService.hitClientOrder(true);
      trackingList.assignAll(response.data['trackingList']);
      print("Order trackingList -:: ${trackingList}");
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
