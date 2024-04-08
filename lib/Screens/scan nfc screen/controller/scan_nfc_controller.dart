import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:http/http.dart' as http;
import 'package:scan_cart_clone/Models/admin_login_model.dart';

class ScanNFCController extends GetxController {
  //! Variable Declare
  Rx<TextEditingController> promoCodeController = TextEditingController().obs;
  RxBool isAvailable = false.obs;
  RxBool isShowingAnimationScreen = false.obs;
  RxString adminTokenService = ''.obs;

  //! Calling onInit method
  @override
  void onInit() {
    Timer(Duration.zero, () {
      NFCscan(true);
    });
    super.onInit();
    adminLogin();
  }

  //! Check the inter net Connection

  Future<bool> isInternetConnected() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      log("Connection result :: ${connectivityResult}");
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        log("true");
        return true;
      } else {
        log("false");

        return false;
      }
    } catch (e) {
      log("Error checking internet connection: $e");
      return false;
    }
  }

  //! Making a method to check NFC
  void NFCscan(enable) async {
    if (Platform.isAndroid) {
      log("Platform :: Android");
      NfcManager.instance.startSession(onDiscovered: (NfcTag nfcTag) async {
        if (enable && !isShowingAnimationScreen.value) {
          final ndefTag = await Ndef.from(nfcTag);
          String nfcURL = "";
          log("Ndef message :: ${ndefTag!.cachedMessage}");
          if (ndefTag?.cachedMessage != null) {
            var ndefMessage = ndefTag?.cachedMessage;
            var buffer = StringBuffer();
            try {
              final ndefRecords = ndefMessage!.records;
              for (int i = 0; i < ndefRecords!.length; i++) {
                final nPalyload = ndefRecords[i].payload;
                String decodedData = utf8.decode(nPalyload.toList());
                log("DecodedData :: ${decodedData}");
                if (decodedData.isNotEmpty) {
                  if (decodedData.contains("scanacart.com/nfc")) {
                    log("Yes this contain");
                    nfcURL = decodedData.substring(1);
                    log("NFC URL :: $nfcURL");
                  } else {
                    log("This is Not contain to :: ");
                    buffer.writeln(
                        "Record " + (i + 1).toString() + ". " + decodedData);
                    log("Buffer Write :: ${buffer}");
                  }
                } else {
                  log("$decodedData Is Empty");
                }
              }
            } catch (exception) {
              log("Exceptions :: ${exception.toString()}");
            }
          }
        }
      }, onError: (NfcError error) async {
        log("NFC Error :: $error");
      });
    }
  }

  // Admin Login..
  void adminLogin() async {
    String email = "admin@scanacart.com";
    String password = "Test@1234";
    String userService;
    final String apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fauthenticate";
    log("API URl :: ${apiURL}");

    try {
      final response = await http.post(Uri.parse(apiURL),
          body: {"email": email, "password": password});
      log("Response Data :: ${response.body}");
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['success']) {
          var adminData = AdminLoginModel.fromJson(responseData);
          log("Bind Data from Model :: ${adminData}");
          adminTokenService.value = adminData.token!;
          log("Admin Token Service :: ${adminTokenService}");
        } else {
          log("Login status :: ${responseData['success']}");
        }
      }
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }
}
