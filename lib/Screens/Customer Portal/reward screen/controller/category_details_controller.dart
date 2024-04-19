import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:scan_cart_clone/Models/category_details_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class CategoryDetailsController extends GetxController {
  final int productId;
  final int clientId;

  CategoryDetailsController({
    required this.productId,
    required this.clientId,
  });

  //! Variable declare
  CategoryDetailsModel categoryDetailsModel = CategoryDetailsModel();


  var deatilsImageList = [].obs;
  var productDescription = ''.obs;
  var productTitle = ''.obs;
  var rewardPoints = 0.obs;
  var variantsData = [].obs;
  var categoryDetailsData;
  var colorList = <String>[].obs;
  var color = ''.obs;
  var sizeList = [].obs;
  var size = ''.obs;

  RxInt currentImageIndex = 0.obs;
  var colorDropdownvalue = 'White'.obs;
  var sizeDropdownValue = ''.obs;

  //! Make a function  to get CategoryDetails
  Future<void> getCategoryDetails() async {
    try {
      categoryDetailsData =
          await APIServices.hitCategoryDetails(clientId, productId);
      // deatilsImageList.addAll(categoryDetailsModel.data!.images!);
      log("Category Details Data :: ${categoryDetailsData['data']}");
      if (categoryDetailsData['success'] == true) {
        productDescription.value =
            categoryDetailsData['data']['product_description'];
        print("D :: ${productDescription.value}");
        productTitle.value = categoryDetailsData['data']['product_title'];
        print("PT :: ${productTitle.value}");
        rewardPoints.value = categoryDetailsData['data']['reward_points'];
        print("RE :: ${rewardPoints.value}");
        deatilsImageList.value = categoryDetailsData['data']['images'];
        print("Ima :: ${deatilsImageList.length}");
        // for (int i = 0;
        //     i < categoryDetailsData['data']['images'].length;
        //     i++) {
        //
        // }
        color.value = categoryDetailsData['data']['variants']['color'];
        var du = color.value.split(',');
        colorList.value = du.map((e) => '"$e"').toList();
        print("Color :: ${colorList}");
        // print("ColorLength :: ${colorList.toString().length}");
        size.value = categoryDetailsData['data']['variants']['size'] ;
        var duu = size.value.split(',');
        sizeList.value = duu.map((e) => '"$e"').toList();
        print("Size :: ${sizeList}");
      }
      // print("L = ${data.toString()}");
      // print("List :: => ${}");
      // }
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }

  @override
  void onInit() {
    getCategoryDetails();
    super.onInit();
  }
}
