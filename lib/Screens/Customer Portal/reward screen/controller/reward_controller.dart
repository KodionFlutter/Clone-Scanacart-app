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
  List<Rewards> rewardata = [];
  RxString cardPath = "".obs;

  RxBool isExpanded = false.obs;
  late AnimationController animationController;
  late Animation<double> rotateAnimation;

//! Get Reward
  Future<void> getReward() async {
    rewardata.clear();
    try {
      rewardModel = await APIServices.customerReward(id);
      rewardata.addAll(rewardModel.data!.rewards!);
      // rewardata.assignAll(rewardModel.data!.rewards!);
      update();
      // print("reward list :: ${rewardata[1].cardDetail![0].cardName}");
    } catch (error) {
      "Error :: ${error.toString()}";
    }
  }

  void getCardPath() {
    cardPath.value = rewardata[1].cardDetail![0].cardName!;
    switch (cardPath.value) {
      case 'Gold':
        cardPath.value = "assets/images/gold.png";
      case 'Platinum':
        cardPath.value = "assets/images/gold.png";
      case 'Diamond':
        cardPath.value = "assets/images/gold.png";
      case 'Diamond Plus':
        cardPath.value = "assets/images/gold.png";
      case 'Diamond Elite':
        cardPath.value = "assets/images/gold.png";
    }
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, () => getReward())
        .then((value) => getCardPath());

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    rotateAnimation = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticInOut,
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
