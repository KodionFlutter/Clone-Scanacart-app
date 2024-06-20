import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:scan_cart_clone/Models/label_validations_location_model.dart';
import 'package:scan_cart_clone/Models/recent_email_model.dart';
import 'package:scan_cart_clone/Models/serial_vali_model.dart';
import 'package:scan_cart_clone/Models/serial_validation_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/dio_client.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DashboardController extends GetxController {
  Rx<TooltipBehavior> tooltipBehavior = TooltipBehavior().obs;
  List<LabelValidationLocationModel> labelValidationData = [];
  MapShapeSource? mapSource;

  RxBool isLoading = false.obs;
  RxBool isSocialLoading = false.obs;
  RxBool isVerifiedLoading = false.obs;
  RxBool isLabelLoading = false.obs;
  RxBool isLabelLocationLoading = false.obs;
  RxBool isSelected = true.obs;

  String adminClientLogo = "";
  RxString logo = "".obs;
  RxString totalVerified = ''.obs;
  var errorMessage = ''.obs;

  RxList emailList = <RecentEmailList>[].obs;
  RxList socialList = [].obs;
  RxList labelValidationList = <SerialValiModel>[].obs;
  RxList cartData = <SerialValidationModel>[].obs;

  SerialValiModel serialValiModel = SerialValiModel();
  RecentEmailModel recentEmailModel = RecentEmailModel();

  //!
  Future getLabelValidationLocation() async {
    isLabelLocationLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    var data = await APIServices.hitLabelValidationLocation(clientID!, token);
    print("This is data :: $data");
    labelValidationData.clear();
    for (int i = 0; i < data.length; i++) {
      var color = int.parse(data[i]['color']);
      labelValidationData.add(LabelValidationLocationModel(
        city: "${data[i]['city']}",
        color: Color(color),
        latitude: data[i]['latitude'].toDouble(),
        longitude: data[i]['longitude'].toDouble(),
        marker: data[i]['marker'],
        percentage: data[i]['percentage'],
      ));
    }
    mapSource = MapShapeSource.asset(
      'assets/geo_locations/us.json',
      shapeDataField: 'NAME',
      dataCount: labelValidationData.length,
      primaryValueMapper: (int index) => labelValidationData[index].city!,
      dataLabelMapper: (int index) =>
          labelValidationData[index].city!.toString(),
      shapeColorValueMapper: (int index) => labelValidationData[index].color,
      bubbleColorValueMapper: (int index) => labelValidationData[index].marker,
    );
    isLabelLocationLoading.value = false;
    print("is list : ${mapSource?.dataCount}");
  }

  //! Most RecentEmails..
  Future getMostRecentEmails() async {
    isLoading.value = true;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("admin_token");
      int? clientID = prefs.getInt("client_id");
      print("Client id: $clientID");
      DioService dioService = DioService(
        baseUrl: ApiServiceConfig.apiBaseUrl,
        clientId: "$clientID",
        token: "$token",
      );
      // recentEmailModel = await APIServices.hitMostRecentEmail(clientID!, token!);
      recentEmailModel = await dioService.hitMostRecentEmail();
      print("ooo =: ${recentEmailModel.success}");
      emailList.addAll(recentEmailModel.recentEmailList!);
      print("List is ${emailList.length}");
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage(e.toString());
    } finally {
      isLoading.value = false;
      isLoading(false);
    }
  }

  //! Getting the Label Validations here../!

  Future getLabelValidation(String days) async {
    isLabelLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    labelValidationList.clear();
    var data = await APIServices.hitSerialValidations(clientID!, token, days);
    print("laa :: $data");
    if (data['success'] == true) {
      if (days == "days") {
        for (final items in data['data'].entries) {
          print("Items : ${items.value}");
          labelValidationList.add(SerialValiModel(
            x: items.key,
            y: items.value.toDouble(),
          ));
        }
        isLabelLoading.value = false;
        print("list is days ::$labelValidationList");
      } else {
        for (int i = 0; i < data['data'].length; i++) {
          labelValidationList.add(SerialValiModel(
            x: data['data'][i]['date'],
            y: data["data"][i]['value'].toDouble(),
          ));
        }
        isLabelLoading.value = false;
        print("list is month ::$labelValidationList");
      }
    }
  }

  //! Get the social Media List
  Future getSocialMediaList() async {
    isSocialLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    var data = await APIServices.hitSocialMedialAPI(clientID!, token);
    socialList.addAll(data);
    print("d : ${socialList[0]["instagram"]}");
    isSocialLoading.value = false;
  }

  //! Get the Admin Details
  getAdminDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    adminClientLogo = prefs.getString("admin_client_logo")!;
    logo.value = "${ApiServiceConfig.logoLink}$adminClientLogo";
    print("Logo : $logo");
  }

  //! Get serial validation verify

  Future getSerialValidationVerify() async {
    isVerifiedLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    var data = await APIServices.hitSerialValidationVerified(clientID!, token);
    for (int i = 0; i < data['serialValVerifiedData'].length; i++) {
      cartData.add(SerialValidationModel(
        label: data['serialValVerifiedData'][i]['label'],
        values: data['serialValVerifiedData'][i]['value'].toDouble(),
      ));
    }
    var s = data['verifiedOutOf'];
    totalVerified.value = s.toString().split('/')[0];
    isVerifiedLoading.value = false;
    update();
    refresh();
  }

  @override
  void onInit() async {
    getMostRecentEmails();
    getAdminDetails();
    getSocialMediaList();
    getLabelValidation("days");
    getLabelValidationLocation();
    getSerialValidationVerify();
    // labelValidationData = [
    //   LabelValidationLocationModel(
    //       city: 'Washington',
    //       marker: 0,
    //       longitude: 47.3758615,
    //       latitude: -121.587695,
    //       color: "0xffFFFFFF",
    //       percentage: "0"),
    // ];

    super.onInit();
    tooltipBehavior.value = TooltipBehavior(
        enable: true,
        builder: (dynamic serialValidationData, dynamic point, dynamic series,
            int pointIndex, int seriesIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.black,
                child: Text(
                  '${serialValidationData.x.toString()} : ${serialValidationData.y.toInt()}',
                  style: const TextStyle(color: Colors.white),
                )),
          );
        });

    // labelValidationData = const <LabelValidationLocationModel>[
    //   LabelValidationLocationModel(
    //       'Washington', -121.587695, 47.3758615, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Oregon', -121.1984117, 43.9151184, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'California', -120.230263, 36.7497019, 2, Color(0xff08519C), 23.1),
    //   LabelValidationLocationModel(
    //       'California', -121.3427453, 40.4643841, 1, Color(0xff08519C), 23.1),
    //   LabelValidationLocationModel(
    //       'California', -121.6029006, 40.3361977, 1, Color(0xff08519C), 23.1),
    //   LabelValidationLocationModel(
    //       'California', -116.4766553, 35.2115868, 1, Color(0xff08519C), 23.1),
    //   LabelValidationLocationModel(
    //       'California', -120.230263, 36.7497019, 2, Color(0xff08519C), 23.1),
    //   LabelValidationLocationModel(
    //       'California', -116.3608517, 36.1720402, 1, Color(0xff08519C), 23.1),
    //   LabelValidationLocationModel(
    //       'Idaho', -114.4492593, 43.6864221, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Nevada', -119.1547429, 39.1483687, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Arizona', -114.0750518, 34.2363403, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Montana', -109.5838889, 46.7938642, 2, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Montana', -113.3198934, 47.2817814, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Montana', -110.837548, 47.2768772, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Montana', -110.8847433, 48.3428176, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Montana', -106.831985, 48.3141568, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Montana', -107.8396848, 46.0057549, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Wyoming', -108.7327083, 43.0527143, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Colorado', -106.7729299, 39.1577026, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'New Mexico', -108.2252796, 34.2161037, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'North Dakota', -101.4581084, 47.4254957, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'South Dakota', -101.4416981, 44.4089347, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'Nebraska', -101.9652173, 41.5162668, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Kansas', -99.5589535, 38.5311045, 2, Color(0xffFFFFFF), 3.8),
    //   LabelValidationLocationModel(
    //       'Kentucky', -86.6446113, 37.6772022, 1, Color(0xffFFFFFF), 2.6),
    //   LabelValidationLocationModel(
    //       'Indiana', -86.4030021, 39.9645514, 1, Color(0xffFFFFFF), 2.6),
    //   LabelValidationLocationModel(
    //       'Oklahoma', -100.3770265, 35.6063897, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Texas', -104.114098, 31.2209729, 2, Color(0xff89AED3), 10.3),
    //   LabelValidationLocationModel(
    //       'Texas', -99.4383003, 30.0177709, 1, Color(0xff89AED3), 10.3),
    //   LabelValidationLocationModel(
    //       'Texas', -103.1958143, 36.0484752, 1, Color(0xff89AED3), 10.3),
    //   LabelValidationLocationModel(
    //       'Texas', -98.4480586, 33.6245009, 1, Color(0xff89AED3), 10.3),
    //   LabelValidationLocationModel(
    //       'Utah', -113.9529825, 39.3410571, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Minnesota', -97.8520511, 46.3615446, 1, Color(0xffFFFFFF), 2.6),
    //   LabelValidationLocationModel(
    //       'Iowa', -94.4911099, 42.0083769, 1, Color(0xffDEEBF7), 7.7),
    //   LabelValidationLocationModel(
    //       'Mississippi', -89.8936505, 32.9470953, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'Missouri', -93.5331652, 38.3371653, 0, Color(0xffDEEBF7), 0),
    //   LabelValidationLocationModel(
    //       'Arkansas', -93.1947129, 34.7200568, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Louisiana', -92.7116222, 31.0239283, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'Wisconsin', -91.9073564, 44.7542053, 1, Color(0xffFFFFFF), 2.6),
    //   LabelValidationLocationModel(
    //       'Illinois', -91.419422, 40.378264, 1, Color(0xffFFFFFF), 5.1),
    //   LabelValidationLocationModel(
    //       'Tennessee', -89.733095, 36.000608, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'Alabama', -88.327302, 30.229882, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Michigan', -84.59024, 45.812801, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Ohio', -84.805972, 41.696118, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Georgia', -85.605165, 34.984678, 1, Color(0xff749ECA), 12.8),
    //   LabelValidationLocationModel(
    //       'Georgia', -84.6153279, 31.196583, 1, Color(0xff749ECA), 12.8),
    //   LabelValidationLocationModel(
    //       'Georgia', -85.6173394, 33.8140486, 1, Color(0xff749ECA), 12.8),
    //   LabelValidationLocationModel(
    //       'Georgia', -85.5037894, 32.8653968, 1, Color(0xff749ECA), 12.8),
    //   LabelValidationLocationModel(
    //       'Georgia', -84.7959181, 30.9349601, 1, Color(0xff749ECA), 12.8),
    //   LabelValidationLocationModel(
    //       'Florida', -80.84849, 24.804713, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'Florida', -83.3032367, 30.27746573, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'Florida', -81.6935346, 26.6337153, 1, Color(0xffDEEBF7), 2.6),
    //   LabelValidationLocationModel(
    //       'West Virginia', -82.59348, 38.421821, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Virginia', -75.648229, 37.966775, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'North Carolina', -75.726807, 35.935844, 0, Color(0xff749ECA), 12.8),
    //   LabelValidationLocationModel(
    //       'South Carolina', -82.783283, 35.0856, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Pennsylvania', -80.519425, 41.977523, 1, Color(0xffFFFFFF), 2.3),
    //   LabelValidationLocationModel(
    //       'Pennsylvania', -80.7355602, 40.4824476, 1, Color(0xffFFFFFF), 2.3),
    //   LabelValidationLocationModel(
    //       'Pennsylvania', -80.4160551, 42.0289458, 1, Color(0xffFFFFFF), 2.3),
    //   LabelValidationLocationModel('District of Columbia', -77.119759,
    //       38.934343, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Delaware', -75.788596, 39.722199, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'New Jersy', -75.509742, 39.686113, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'New York', -74.256088, 40.507903, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Connecticut', -73.487314, 42.049638, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Vermont', -73.343124, 45.01084, 1, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Rhode Island', -71.19564, 41.67509, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'New Hampshire', -71.501088, 45.013349, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Maine', -68.501158, 44.153966, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Alaska', -160.0753685, 64.4415582, 0, Color(0xffFFFFFF), 0),
    //   LabelValidationLocationModel(
    //       'Hawaii', -159.4864196, 20.2060762, 0, Color(0xffFFFFFF), 0),
    // ];
  }
}
