import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Models/address_model.dart';
import 'package:scan_cart_clone/Models/admin_login_model.dart';
import 'package:scan_cart_clone/Models/category_model.dart';
import 'package:scan_cart_clone/Models/common_model.dart';
import 'package:scan_cart_clone/Models/customer_signup_model.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:scan_cart_clone/Models/order_details_model.dart';
import 'package:scan_cart_clone/Models/order_model.dart';
import 'package:scan_cart_clone/Models/recent_email_model.dart';
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
          log("Bound Data into Model :: ${responseData['token']}");
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
      String token, int clientId, String procodeText) async {
    try {
      log("Token :: $token\n Client id :: $clientId\n promcode_text :: $procodeText");
      String url =
          '${ApiServiceConfig.apiBaseUrl}/dashboard/CodeValidation?client_id=$clientId&code=$procodeText';
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
        print("decoded Data :: $decodedData");
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

    log("Verification mail :: $url");
    try {
      final response = await BaseService.getAPI(url);
      print("This is otp Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        print("This is verify Decoded Data :: $decodeData");
        var successflag = decodeData['success'];
        if (successflag == true) {
          showMessage(
              "${decodeData['message']}", AppColors.whiteBackgroundColor);
          return successflag;
        } else {
          showMessage("Invalid code", AppColors.whiteBackgroundColor);
        }
        print("$decodeData");
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
        '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/loginCustomer&email=${email.toString()}&phone=$phone';
    print("Login url :: $url");
    try {
      final response = await BaseService.getAPI(url);
      print("Customer signin Response :: ${response.body.toString()}");
      log("message :: $response");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print("decoded Data :: $decodedData");
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
    print("Customer Reward Point :: $url");

    try {
      final response = await BaseService.getAPI(url);
      log("Reward response == ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        log("Reward Decoded Data :: $decodedData");
        if (decodedData['success'] == true) {
          return decodedData;
        } else {
          if (kDebugMode) {
            print("Error occur during the Reward API Fetching");
          }
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
    print("Product Category :: $url");
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
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/categoryProducts&category_id=$categoryId&client_id=$clientId";
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
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/clientProducts&client_id=$clientId&product_id=$productId";
    print("This is Category details url :: $url");
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
    print(" This is Credit Rewards :: $url");

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

  static Future productPlaceOrder(Map<String, dynamic> map) async {
    var url =
        '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/customerShipping';
    print("This is Shipping URL :: $url");
    try {
      var response = await BaseService.baseServiceGet(url, map, "");
      log('Response of Shipping  :: ${response.body}');
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

  //!  Shipping and Place order ..

  static hitPlaceOrder(Map<String, dynamic> map) async {
    try {
      var response = await BaseService.baseServiceGet(
          '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/customerShipping',
          map,
          "");
      log('place order : = ${response.body.toString()}');
      if (response.statusCode == 200) {
        var parseData = json.decode(response.body);
        if (parseData['success'] == true) {
          return parseData;
        } else {
          print("There is Problem");
          throw Exception(parseData['message']);
        }
      }
    } on SocketException {
      throw Exception('No Connection');
    }
  }

  //! Hit here for address List ...

  static hitAddressList(int? customerId, String? token) async {
    var url =
        '${ApiServiceConfig.apiBaseUrl}?endpoint=/customer/customerShipping&customer_id=$customerId';

    try {
      final response = await BaseService.getMethod(url, token);
      print("This is Address response : ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          return AddressModel.fromJson(decodedData);
        } else {
          print("There is Problem  to get the Address API");
          throw Exception(decodedData['message']);
        }
      }
    } on SocketException {
      throw Exception('No Connection');
    }
  }

  //! Hit the Order List

  static hitOrderList(customerId, status) async {
    var url =
        '${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/rewardOrders&customer_id=$customerId&order_status=$status';
    print("OrderList API : $url");
    try {
      final response = await BaseService.getAPI(url);
      log("This is Order List response : ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          return OrderModel.fromJson(decodedData);
        } else {
          throw Exception(decodedData['message']);
        }
      }
    } on SocketException {
      throw Exception('No Connection');
    }
  }

  //! Here we hit the ViewOrderDetails

  static hitViewOrderDetails(orderId) async {
    var url =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/rewardOrderDetail&order_id=$orderId";
    print("This is View Order details API : $url");
    try {
      final response = await BaseService.getAPI(url);
      log("View Order Details : ${response.body.toString()}");

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body.toString());
        if (decodedData['success'] == true) {
          return OrderDetailsModel.fromJson(decodedData);
        } else {
          throw Exception(decodedData['message']);
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Hit the cancel product API

  static hitCancelProduct(map, token) async {
    var url = '${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/cancelOrder';
    print("This is cancel order URL : $url");
    try {
      var response = await BaseService.baseServiceGet(url, map, token);
      log("Cancel response : ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          return CommonModel.fromJson(decodedData);
        } else {
          throw Exception(decodedData['message']);
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! hit here add note of product

  static Future hitAddNotes(map) async {
    var url = '${ApiServiceConfig.apiBaseUrl}?endpoint=/rewards/addOrderNotes';
    print("Add notes in product details : $url");
    try {
      var response;
      response = await BaseService.putMethod(url, map);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          log("Add note response : $decodedData");
          return CommonModel.fromJson(decodedData);
        } else {
          print("Exception is working");
          throw Exception(decodedData['message']);
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  static hitClientLogin(Map<String, dynamic> map) async {
    var apiURL = "${ApiServiceConfig.apiBaseUrl}/authenticate";
    print("This is client Login API: $apiURL");
    try {
      var response = await BaseService.postMethod(apiURL, map);
      print("Client Login Response : ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return AdminLoginModel.fromJson(decodedData);
        } else {
          showMessage(
              "${decodedData['message']}", AppColors.whiteBackgroundColor);
          // throw Exception(decodedData['message'].toString());
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Hit Most Recent Emails.
  static hitMostRecentEmail(int clientID, String token) async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fdashboard%2FmostRecent&client_id=$clientID";
    print("Most Recent Emails: $apiURL");
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Most Recent Email Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodeData = json.decode(response.body);
        if (decodeData['success'] == true) {
          return RecentEmailModel.fromJson(decodeData);
        } else {
          return "Field";
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Hit the Social Media

  static hitSocialMedialAPI(int clientId, token) async {
    var apiURL =
        '${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fdashboard%2FsocialMediaClick&client_id=$clientId';
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Social Medial Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodeData = json.decode(response.body);
        if (decodeData["success"] == true) {
          return decodeData["socialMediaClicks"];
        } else {
          return "Error";
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  // ! Label Validations API...
  static hitSerialValidations(clientID, token, value) async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=/maps/nfcGraphdays&client_id=$clientID&type=$value";
    log("Serial Validations API :: $apiURL");
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Serial Validations API Response:: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return decodedData;
        } else {
          return "Error occur";
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Hit Serial Validations Verified ..
  static hitSerialValidationVerified(int clientID, token) async {
    final String apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fdashboard%2FserialValidationVerified&client_id=$clientID";
    print("SerialValidationVerified API : $apiURL");
    try {
      var response = await BaseService.getMethod(apiURL, token);
      print(
          "Serial Validation Verified response : ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        return decodedData;
      } else {
        print("Exception is working");
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Label Validations Location ....

  static hitLabelValidationLocation(int clientID, token) async {
    var apiURL =
        '${ApiServiceConfig.apiBaseUrl}/dashboard/labelValidation?client_id=$clientID';
    log("Label validation Location :: $apiURL");
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Label Validation Location Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        if (decodedData['success'] == true) {
          return decodedData['labelValidation'];
        } else {
          return "Load Filed";
        }
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Top Countries
  static hitTopCountries(clientID, token) async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fmaps%2FtopCountries&client_id=$clientID";
    log("Top Countries API : $apiURL");
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Top Countries Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        return decodedData;
      } else {
        throw Exception("Failed ");
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Top Countries
  static hitTopUSState(clientID, token) async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fmaps%2FtopUSStates&client_id=$clientID";
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Top US State Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        return decodedData;
      } else {
        throw Exception("Failed ");
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }

  //! Top Countries
  static hitTopCities(clientID, token) async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fmaps%2FtopCities&client_id=$clientID";
    try {
      var response = await BaseService.getMethod(apiURL, token);
      log("Top Cities Response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        return decodedData;
      } else {
        throw Exception("Failed ");
      }
    } on SocketException {
      throw Exception("No Connection");
    }
  }
}
