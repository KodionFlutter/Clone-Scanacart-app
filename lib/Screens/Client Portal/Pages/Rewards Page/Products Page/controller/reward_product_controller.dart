import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class RewardProductController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;

  RxString dropDownValue = "Active".obs;
  RxList statusList = ["Active", "In-Active"].obs;
}