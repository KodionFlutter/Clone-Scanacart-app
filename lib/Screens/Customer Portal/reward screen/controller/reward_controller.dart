import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/reward_model.dart';
import 'dart:math' as math;

import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class RewardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int id;

  RewardController({required this.id});

  //! Variable declare

  RewardModel rewardModel = RewardModel();

  late AnimationController animationController;
  late Animation<double> rotateAnimation;

  RxBool isExpanded = false.obs;
  RxBool isPopupVisible = false.obs;

  RxString customerName = ''.obs;
  RxString cardPath = "".obs;
  RxString cardName = ''.obs;

  var rewardPoints1 = 0.obs;
  var clientId1 = 0.obs;
  var clientName1 = ''.obs;
  var clientLogo1 = ''.obs;

  var rewardPoints2 = 0.obs;
  var clientId2 = 0.obs;
  var clientName2 = ''.obs;
  var clientLogo2 = ''.obs;
  var maxRange = 0.obs;
  var minRange = 0.obs;
  dynamic rewardData = ().obs;
  Map<dynamic, dynamic> data = {}.obs;

//! Get Reward
  Future<void> getReward() async {
    try {
      rewardData = await APIServices.customerReward(id);
      data.addAll(rewardData['data']);

      // print("Reward Data => ${rewardData['data']}");
      customerName.value = rewardData['data']['customer_name'];
      print("Customer Name :=> $customerName");

      for (var item in rewardData['data']['rewards']) {
        if (item['card_detail'] == null) {
          clientId1.value = item['client_id'];
          clientName1.value = item['client_name'];
          clientLogo1.value = item['client_logo'];
          rewardPoints1.value = item['reward_points'];
          print(
              "client 1 :=> $clientId1 \n name : $clientName1 \n Logo :$clientLogo1 \n rePoints : $rewardPoints1");
        }

        if (item['card_detail'] != null) {
          for (var cardDetail in item['card_detail']) {
            clientId2.value = item['client_id'];
            clientName2.value = item['client_name'];
            rewardPoints2.value = item['reward_points'];
            clientLogo2.value = item['client_logo'];
            maxRange.value = cardDetail['max_range'];
            minRange.value = cardDetail['min_range'];
            cardName.value = cardDetail['card_name'];

            print("clientId2 :=> $clientId2");
            print("MaxRange :=> $maxRange");
          }
        }
      }

      update();
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }

  getCardPath() async {
    cardPath.value = cardName.value;
    switch (cardPath.value) {
      case 'Gold':
        cardPath.value = "assets/images/gold.png";
      case 'Platinum':
        cardPath.value = "assets/images/platinum.png";
      case 'Diamond':
        cardPath.value = "assets/images/Diamond.png";
      case 'Diamond Plus':
        cardPath.value = "assets/images/Diamond.png";
      case 'Diamond Elite':
        cardPath.value = "assets/images/Diamond.png";
    }
  }

  void hidePopUp() {
    isPopupVisible.value = false;
  }

  // Make a function to show the PopUp
  void showPopUp() {
    isPopupVisible.value = true;
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, () => getReward())
        .then((value) => getCardPath());

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    rotateAnimation = Tween<double>(
      begin: 0,
      end: math.pi * 2,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    ));
    super.onInit();
  }

  //! Toggle floating button
  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }
}
