import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:scan_cart_clone/Common/App%20Config/api_service_config.dart';
import 'package:scan_cart_clone/Models/recent_email_model.dart';

class DioService {
  final String baseUrl;
  final String clientId;
  var token;

  DioService({required this.baseUrl, required this.clientId, this.token});

  Dio _dio() {
    return Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'authorization': '$token',
      },
    ));
  }

  //!  Hit Most Recent Emails.

  Future hitMostRecentEmail() async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}?endpoint=%2Fdashboard%2FmostRecent&client_id=$clientId";
    debugPrint("Most Recent Emails: $apiURL");
    try {
      final response = await _dio().get(
        '$baseUrl?endpoint=%2Fdashboard%2FmostRecent&client_id=$clientId',
      );
      debugPrint("Most Recent Email Response :: ${response.data}");
      // print("Response code :: ${response.statusCode}");
      if (response.statusCode == 200) {
        // var decodedData = json.decode(response.data.toString());
        if (response.data['success'] == true) {
          return RecentEmailModel.fromJson(response.data);
        } else {
          return "Status Code :: ${response.statusCode}";
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('Error: ${e.response?.data}');
        throw Exception(
            'Failed to load Most Recent Email: ${e.response?.data}');
      } else {
        debugPrint('Error: ${e.message}');
        throw Exception('Failed to load Most Recent Email: ${e.message}');
      }
    }
  }

  //! Here Getting the top
  Future hitTopUSStates() async {
    try {
      final response = await _dio()
          .get('$baseUrl?endpoint=%2Fmaps%2FtopUSStates&client_id=$clientId');
      debugPrint("Response of To Us State :: ${response.data}");
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.data);
        return decodedData;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('Error: ${e.response?.data}');
        throw Exception('Failed to load US States: ${e.response?.statusCode}');
      } else {
        debugPrint('Error: ${e.message}');
        throw Exception('Failed to load US States: ${e.message}');
      }
    }
  }

  //! Here we are hit the Client Order API...

  Future hitClientOrder(bool show) async {
    var apiURL =
        "${ApiServiceConfig.apiBaseUrl}//order?client_id=${clientId.toString()}&showAll=$show";
    debugPrint("This is ClientOrder URL : $apiURL");
    try {
      final response = await _dio()
          .get('//order?client_id=${clientId.toString()}&showAll=$show');
      debugPrint("Response of Client Order :: ${response.data}");
      // print("code : ${response.statusCode}");
      if (response.statusCode == 200) {
        // print("Working");
        // var decodedData = json.decode(response.data);
        // print("Decoed === > $decodedData");
        return response.data;
      } else {
        debugPrint("Filed to Load Data ");
      }

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('Error: ${e.response?.data}');
        throw Exception(
            'Failed to load Client Order: ${e.response?.statusCode}');
      } else {
        debugPrint('Error: ${e.message}');
        throw Exception('Failed to load Client Order : ${e.message}');
      }
    }
  }
}
