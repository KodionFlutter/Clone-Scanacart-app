import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardOrderController extends GetxController {
  //!
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> selectDateController = TextEditingController().obs;
  RxString dropDownValue = "All".obs;
  RxList dropDownList = ["All", "Pending", "Cancelled", "Fulfilled"].obs;
  RxString selectedStartDate = "".obs;
  RxString selectedEndDate = "".obs;

  //! Make her Date Choose method ..

  Future chooseDateRange() async {
    DateTimeRange selectedRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
    selectedStartDate.value = selectedRange.start.toString();
    selectedEndDate.value = selectedRange.end.toString();
  }
}