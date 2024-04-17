import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scan_cart_clone/Base%20service/services.dart';
import 'package:scan_cart_clone/Models/admin_login_model.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:scan_cart_clone/Screens/nfc%20loading/nfc_loading.dart';
import 'package:scan_cart_clone/Screens/product%20screen/product_screen.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/pages/ready_to_scan_page.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/alert_dialobbox_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/nfc_enable_error_dailog_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanNFCController extends GetxController {
  //! Variable Declare
  Rx<TextEditingController> promoCodeController = TextEditingController().obs;
  RxBool isAvailable = false.obs;
  RxBool isShowingAnimationScreen = false.obs;
  RxString adminTokenService = ''.obs;
  RxBool selected = false.obs;
  RxString promoCode = "".obs;
  RxInt clientId = 0.obs;
  RxString logoPath = ''.obs;
  RxString employee_clientId = ''.obs;
  RxString clientURl = ''.obs;
  RxString clientName = ''.obs;
  RxBool responseSuccess = false.obs;
  RxString codeValidationMessage = ''.obs;
  RxString videoURL = ''.obs;
  RxInt serialNumber = 0.obs;
  EmployeeDataModel employeeDataModel = EmployeeDataModel();


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
  Future NFCscan(enable) async {
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

          //! Here we need to check and perform
          if (await isInternetConnected()) {
            showNFCLoadingScreen(navigatorKey.currentState!.context);
            log("Internet is Connected");
            if (adminTokenService.isEmpty) {
              await adminLogin();
              log("adminServiceToken isAvailable :: ${adminTokenService.value}");
              validateNFCTag(navigatorKey.currentState!.context,
                  getSerialNumberFromTag(nfcTag), nfcURL);
            } else {
              log("userServiceToken :: ${adminTokenService.value}");
              validateNFCTag(navigatorKey.currentState!.context,
                  getSerialNumberFromTag(nfcTag), nfcURL);
            }
          } else {
            showDialog(
                context: navigatorKey.currentState!.context,
                builder: (_) {
                  return AlertDialogBoxWidget(
                    title: 'Alert',
                    message: 'You are offline',
                  );
                });
          }
        }
      }, onError: (NfcError error) async {
        log("NFC Error :: $error");
      });
    }
  }

  // Admin Login..
  Future adminLogin() async {
    String email = "admin@scanacart.com";
    String password = "Test@1234";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //! Calling adminModel
    try {
      var loginModel = AdminLoginModel();
      loginModel =
          await APIServices.login({"email": email, "password": password});
      await prefs.setString("Token", loginModel.token!);

      adminTokenService.value = loginModel.token!;
      log("Admin token :: ${adminTokenService}");
      clientId.value = loginModel.clientId!;

      log("Client id :: ${loginModel.clientId}");
    } catch (error) {
      log("Error :: ${error.toString()}");
    }
  }

  // Calling the NFC Loading screen
  showNFCLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = true;
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return NfcLoadingScreen();
      },
    );
  }

  //Hide
  hideNFCLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = false;
    Get.back();
  }

  //! Making a method to get Serial Number from Tag ..

  String getSerialNumberFromTag(NfcTag tag) {
    String identifier1 = "N/A";
    log("Tag Data :: ${tag.toString()}");
    try {
      if ((Platform.isAndroid)) {
        Uint8List identifier =
            Uint8List.fromList(tag.data["ndef"]['identifier']);
        identifier1 = identifier
            .map((e) => e.toRadixString(16).padLeft(2, '0'))
            .join(':');
      } else {
        Uint8List identifier =
            Uint8List.fromList(tag.data["mifare"]['identifier']);
        identifier1 = identifier
            .map((e) => e.toRadixString(16).padLeft(2, '0'))
            .join(':');
      }
      print("Serial number " + identifier1);
    } catch (e) {}

    return "" + identifier1;
  }

  //! Making a function for validate the NFC tag
  Future validateNFCTag(
      BuildContext context, String serialNumber, String productPage) async {
    if (adminTokenService.value.isEmpty ||
        adminTokenService.value.toString().isEmpty) {
      const AlertDialogBoxWidget(
        title: 'Authorization Error',
        message: 'Token is empty',
      );
    }
    final queryParameter = {
      'serial_no': '${serialNumber}',
      'product_page': 'https://www.${productPage}',
    };
    log("Token :: ${adminTokenService.value.toString()}");
    if (isShowingAnimationScreen.value) {
      hideNFCLoadingScreen(navigatorKey.currentState!.context);
    }
    await APIServices.nfcValidateTagMethod(
        queryParameter, adminTokenService.value.toString());
  }

  // to check the NFC is Available or Not
  void tagRead() async {
    log("Tag read button :: ");
    isAvailable.value = await NfcManager.instance.isAvailable();
    log(isAvailable.toString());
    if (!isAvailable.value) {
      showDialog(
          context: navigatorKey.currentState!.context,
          builder: (builder) {
            return NotAvailableWidget(
              height: MediaQuery.of(navigatorKey.currentState!.context)
                      .size
                      .height *
                  0.3,
              message: "Please enable NFC in settings",
            );
          });
      log('NFC is not available');
    } else {
      if (Platform.isAndroid) {
        showDialog(
            context: navigatorKey.currentState!.context,
            builder: (_) => ReadyToScanPage());
      }
    }

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag nfcTag) async {
        if (Platform.isAndroid) {
          Get.back();
        }
        if (Platform.isIOS) {
          try {
            NfcManager.instance.stopSession();
          } catch (exception) {
            log("Ios NFC manage exception :: ${exception.toString()}");
          }
        }

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
                  log("Not contain");
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
        // Here we check the internet connecting or not

        if (await isInternetConnected()) {
          showNFCLoadingScreen(navigatorKey.currentState!.context);
          if (adminTokenService.value.isEmpty) {
            await adminLogin();
            validateNFCTag(navigatorKey.currentState!.context,
                getSerialNumberFromTag(nfcTag), nfcURL);
            log("Internet is Connected");
          } else {
            validateNFCTag(navigatorKey.currentState!.context,
                getSerialNumberFromTag(nfcTag), nfcURL);
            log("Internet is Connected");
          }
        } else {
          showDialog(
              context: navigatorKey.currentState!.context,
              builder: (_) {
                return AlertDialogBoxWidget(
                  title: 'Alert',
                  message: 'You are offline here',
                );
              });
        }
      },
      onError: (NfcError error) async {
        if (Platform.isIOS) {
          try {
            NfcManager.instance.stopSession();
          } catch (_) {
            //We dont care
          }
        }
        log("Error :: $error");
      },
    );
  }

// Verify the PromoCode ..
  Future getEmployee(String couponCode) async {
    //code::bbsimon578
    try {
      showNFCLoadingScreen(navigatorKey.currentState!.context);
      // Calling the verifyCouponCode fro APIServices ..
      dynamic data = await APIServices.verifyCouponCode(adminTokenService.value,
          clientId.value, promoCodeController.value.text);
      //! The contain message coming from the server.
      if (data.toString().contains(
          "Code not found. This product is not valid. Please contact your vendor")) {
        hideNFCLoadingScreen(navigatorKey.currentState!.context);
        showDialog(
            context: navigatorKey.currentState!.context,
            builder: (_) => NotAvailableWidget(
                  message:
                      "Code not found. This product is not valid. Please contact your vendor",
                  height: AppConstant.size.height * 0.5,
                ));
      } else {
        employeeDataModel=data;
        logoPath.value = employeeDataModel.logoPath!;
        print("This is logo pathThis is logo path == ${logoPath.value}");
        employee_clientId.value = employeeDataModel.clientId.toString();
        clientName.value = employeeDataModel.client!;
        clientURl.value = employeeDataModel.clientURL!;
        videoURL.value = employeeDataModel.videoUrl!;
        serialNumber.value = employeeDataModel.serialNum!;
        print("This is video URL :: ${videoURL.value}");
        print("This is serial Nmber == ${serialNumber.value}");
        selected.value = false;
        hideNFCLoadingScreen(navigatorKey.currentState!.context);
        //! handle the cases ..
        if (videoURL.endsWith('mp4')) {
          Get.to(
            () => ProductScreen(
              responseData: employeeDataModel,
              serialNumber: employeeDataModel.serialNum.toString(),
              couponCode: couponCode,
            ),
          );
        }
      }
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }
}
