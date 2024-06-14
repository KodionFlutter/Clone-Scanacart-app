import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClientOrdersController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> addCommentController = TextEditingController().obs;
}