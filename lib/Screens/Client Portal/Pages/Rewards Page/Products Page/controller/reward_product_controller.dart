import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RewardProductController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;

  RxString dropDownValue = "Active".obs;
  RxList statusList = ["Active", "In-Active"].obs;
}