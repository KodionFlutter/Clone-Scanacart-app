import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecipientController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;

  List emailList = [
    "shiva@gmail.com",
    "shaim@gmail.com",
    "sachinp@gmail.com",
    "skshi@gmail.com",
    "suresh@gmail.com",
    "sangam@gmail.com",
    "shubbham@gmail.com",
    "satendra@gmail.com",
    "sajogita@gmail.com",
    "sanjay@gmail.com",
    "santish@gmail.com",
    "satyam@gmail.com",
    "sajeen@gmail.com",
  ];
  List emailListIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
}