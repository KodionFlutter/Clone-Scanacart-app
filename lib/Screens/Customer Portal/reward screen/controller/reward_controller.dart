import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/reward_model.dart';
import 'dart:math' as math;

import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class RewardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int id;

  RewardController({required this.id});

  RewardModel rewardModel = RewardModel();
  // List<Rewards> rewardata = [];
  final rewardata = <Rewards>[].obs;
  RxString cardPath = "".obs;

  RxBool isExpanded = false.obs;
  late AnimationController animationController;
  late Animation<double> rotateAnimation;
  RxBool isPopupVisible = false.obs;
  RxString customerName = ''.obs;

//! Get Reward
  Future<void> getReward() async {
    rewardata.clear();
    try {
      rewardModel = await APIServices.customerReward(id);
      rewardata.addAll(rewardModel.data!.rewards!);
      customerName.value = rewardModel.data!.customerName!;
      // rewardata.assignAll(rewardModel.data!.rewards!);
      update();
      // print("reward list :: ${rewardata[1].cardDetail![0].cardName}");
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }

  getCardPath() async {
    cardPath.value = rewardata[1].cardDetail![0].cardName!;
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

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }
}
