import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Models/admin_login_model.dart';
import 'package:scan_cart_clone/Models/category_details_model.dart';
import 'package:scan_cart_clone/Models/category_model.dart';
import 'package:scan_cart_clone/Models/customer_signup_model.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:scan_cart_clone/Models/reward_model.dart';
import 'package:scan_cart_clone/Models/view_category_model.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/nfc_enable_error_dailog_widget.dart';
import 'package:scan_cart_clone/Utils/Base%20service/base_service.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class APIServices {
  //! Admin Login
  static Future login(Map<String, dynamic> map) async {
    try {
      String url = "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fauthenticate";
      log("Login URL :: ${url.toString()}");
      final response = await BaseService.postMethod(url, map);
      log("Login Response :: ${response.body}");
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        log("Response Data :: ${responseData.toString()}");
        log("Success :: ${responseData['success']}");
        if (responseData['success'] == true) {
          log("Binded Data into Model :: ${responseData['token']}");
          return AdminLoginModel.fromJson(responseData);
        } else {
          throw Exception(responseData['message']);
        }
      }
    } on SocketException {
      throw Exception("No internet");
    } catch (exception) {
      log("Exception :: ${exception.toString()}\n Exception code :: ${exception.hashCode} ");
    }
  }

  //! validate The NFC Tag

  static Future nfcValidateTagMethod(
      Map<String, dynamic> queryParameters, String token) async {
    try {
      final url =
          "${ApiServiceConfig.apiBaseUrl}${ApiServiceConfig.nfcCodeValidation}";
      log("NFC validate Tag URL :: ${url.toString()}");
      var response =
          await BaseService.getReplaceMethod(url, token, queryParameters);
      log("NFC Validate Response Data :: ${response.body}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          // Bind the Data into the model ..
        } else {
          // show dialog box of invalid tag
          showDialog(
              context: navigatorKey.currentState!.context,
              builder: (_) {
                return NotAvailableWidget(
                  message: '${decodedData['message']}',
                  // height: AppConstant.size.height * 0.5,
                );
              });
        }
      } else {
        throw Exception(response['message']);
      }
    } catch (exception) {
      log("Exception :: ${exception.toString()}\n Exception code :: ${exception.hashCode}");
    }
  }

//! Product Coupon code
  static Future verifyCouponCode(
      String token, int clientId, String procode_text) async {
    try {
      log("Token :: ${token}\n Client id :: $clientId\n procode_text :: $procode_text");
      String url =
          '${ApiServiceConfig.apiBaseUrl}/dashboard/CodeValidation?client_id=${clientId}&code=${procode_text}';
      log("Verify Coupon code URL :: ${url.toString()}");
      var response = await BaseService.getMethod(url, token);
      log("Verify coupon code response :: ${response.body}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        log("Decoded Data of coupon :: ${decodedData.toString()}");
        String codeMessage = decodedData['codeValidationMessage'] ?? "";
        if (codeMessage.isNotEmpty) {
          print("6765875875==> ${codeMessage.toString()}");
          return decodedData['codeValidationMessage'];
        } else {
          return EmployeeDataModel.fromJson(decodedData);
        }
      }
    } on SocketException {
      throw Exception("No internet");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! Customer SignUp..

  static Future customerSignUP(Map<String, dynamic> map) async {
    final url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/registerCustomer";
    try {
      final response = await BaseService.postMethod(url, map);
      print("Customer signup Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print("decoded Data :: ${decodedData}");
        return CustomerSignUpModel.fromJson(decodedData);
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! Verification code

  static Future verificationCode(String otp, String customerID) async {
    String url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/verifyLoginCode&code=${otp.toString()}&customer_id=${customerID.toString()}";

    log("Verification mail :: ${url}");
    try {
      final response = await BaseService.getAPI(url);
      print("This is otp Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        print("This is verify Decoded Data :: ${decodeData}");
        var successflag = decodeData['success'];
        if (successflag == true) {
          showMessage(
              "${decodeData['message']}", AppColors.whiteBackgroundColor);
          return successflag;
        } else {
          showMessage("Invalid code", AppColors.whiteBackgroundColor);
        }
        print("${decodeData}");
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! Customer Login Method ..

  static Future customerLoginMethod(String email, String phone) async {
    String url =
        '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/loginCustomer&email=${email.toString()}&phone=${phone}';
    print("Login url :: ${url}");
    try {
      final response = await BaseService.getAPI(url);
      print("Customer signin Response :: ${response.body.toString()}");
      log("message :: ${response}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print("decoded Data :: ${decodedData}");
        return CustomerSignUpModel.fromJson(decodedData);
      }
    } on SocketException {
      throw Exception("No internet");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! Get Customer Rewards

  static Future customerReward(int customerId) async {
    String url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Frewards%2FcustomerRewards&customer_id=$customerId";
    print("Customer Reward Point :: ${url}");

    try {
      final response = await BaseService.getAPI(url);
      log("Reward response == ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        log("Reward Decoded Data :: ${decodedData}");
        if (decodedData['success'] == true) {
          return decodedData;
        } else {
          print("Error occur during the Reward API Fetching");
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  static Future hitProductCategory(clientId) async {
    String url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/categories&client_id=$clientId";
    print("Product Category :: ${url}");
    try {
      final response = await BaseService.getAPI(url);
      log("Category List :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return CategoryModel.fromJson(decodedData);
        } else {
          print("Error occur during the Category API Fetching");
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! Hit view Category ..
  static Future hitViewCategory(categoryId, clientId) async {
    String url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/categoryProducts&category_id=${categoryId}&client_id=${clientId}";
    print("HitView Category url:: $url");
    try {
      final response = await BaseService.getAPI(url);
      log("ViewCategory response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return ViewCategoryModel.fromJson(decodedData);
        } else {
          print("Error occur during the View Category API Fetching");
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! hit CategoryDetails
  static hitCategoryDetails(clientId, productId) async {
    String url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/clientProducts&client_id=${clientId}&product_id=${productId}";
    print("This is Category details url :: ${url}");
    try {
      final response = await BaseService.getAPI(url);
      log("This is Category Details response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return decodedData;
          // We do not bind Data into the Model..
          // return CategoryDetailsModel.fromJson(decodedData);
        } else {
          print("Error occur during the View Category Details API Fetching");
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

//! Credit Rewards ..

  static Future hitCreditRewards(
      int clientId, String? productRewards, int customerId, token) async {
    var url = '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/rewardsCredit';
    print(" This is Credit Rewards :: ${url}");

    final Map<String, dynamic> requestData = {
      'client_id': clientId,
      'product_rewards': productRewards!,
      'customer_id': customerId,
    };

    try {
      final response =
          await BaseService.postRewardMethod(url, requestData, token);
      log("Credit Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return decodedData;
        } else {
          print("Error occur during the Credit Rewards API Fetching");
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

//! Here we hitting the place order...

  static Future productPlaceOrder(
      Map<String, dynamic> map, String? token) async {
    var url =
        '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/customerShipping';
    print("This is Shipping URL :: ${url}");
    try {
      var response = await BaseService.postRewardMethod(url, map, token);
      log('Response of Shipping  :: ${response.body.toString()}');
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return decodedData;
        } else {
          throw Exception(decodedData['message']);
        }
      }
    } on SocketException {
      throw Exception('No Connection');
    }
  }
}
