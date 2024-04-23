import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class BaseService {
  //! BaseService Post Method
  static Future postMethod(String baseUrl, Map<String, dynamic> map) async {
    var data = await http
        .post(
          Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // 'authorization': token.toString(),
          },
          body: jsonEncode(map),
        )
        .timeout(const Duration(seconds: 20));
    log("Data is :: ${data}");
    return data;
  }

  //!
  //! BaseService Post Method
  static Future postRewardMethod(
      String baseUrl, Map<String, dynamic> map, token) async {
    var data = await http
        .post(
          Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': token.toString(),
          },
          body: jsonEncode(map),
        )
        .timeout(const Duration(seconds: 20));
    log("Data is :: ${data}");
    return data;
  }

  //! BaseService Get and replace Method

  static Future getReplaceMethod(String baseUrl, String token,
      Map<String, dynamic> queryParameters) async {
    var data = await http.get(
        Uri.parse(baseUrl).replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': token.toString()
        }).timeout(const Duration(seconds: 20));
    log("GetReplacedMethod :: ${data}");
    return data;
  }

  //! BaseService getMethod

  static Future getMethod(String baseUrl, String? token) async {
    var data = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      "authorization": token.toString(),
    }).timeout(const Duration(seconds: 20));
    log("GetMethod Data :: ${data}");
    return data;
  }

  static Future getAPI(String baseUrl) async {
    var data = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
    }).timeout(const Duration(seconds: 20));
    log("GetMethod Data :: ${data}");
    return data;
  }
}
