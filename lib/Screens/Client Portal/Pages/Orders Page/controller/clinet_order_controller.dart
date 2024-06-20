import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:scan_cart_clone/Utils/Base%20service/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientOrdersController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> addCommentController = TextEditingController().obs;
  Rx<ExpansionTileController> expansionTileControllerLanguage =
      ExpansionTileController().obs;

  RxList trackingList = [].obs;
  RxList searchResults = [].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  int selected = -1.obs;

  @override
  void onInit() {
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
      print("Res :: ${response}");
      trackingList.addAll(response['trackingList']);
      print("Order trackingList -:: ${trackingList}");
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //! search

  void onQueryChanged(String query) {
    searchResults.value = trackingList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print("Search List :: $searchResults");
  }
}
