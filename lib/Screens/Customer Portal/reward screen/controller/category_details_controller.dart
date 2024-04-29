import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Models/category_details_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

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
  var productImage = ''.obs;

  RxInt currentImageIndex = 0.obs;
  var colorDropdownvalue = ''.obs;
  var sizeDropdownValue = ''.obs;

  var stockQuantity = 1.obs;
  var items = [].obs;
  var currentClientID;

  // var imgList = [
  //   "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
  //   "https://cdn.create.vista.com/api/media/small/58244841/stock-photo-colourful-flying-parrot-in-tropical-landscape",
  //   "https://images.pexels.com/photos/1067562/pexels-photo-1067562.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  // ].obs;

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

        //!
        // stockQuantity.value = categoryDetailsData['data']['stock_quantity'];
        print("The total Stock Qunatity is :: ${stockQuantity}");
        productImage.value = categoryDetailsData['data']['product_image'];

        color.value = categoryDetailsData['data']['variants']['color'];
        colorList.value = color.value.split(',');
        //Covert into string form "String"
        // colorList.value = du.map((e) => '"$e"').toList();
        // sizeList.value = duu.map((e) => '"$e"').toList();

        print("Color :: ${colorList}");
        colorDropdownvalue.value = colorList[0];
        // print("ColorLength :: ${colorList.toString().length}");
        size.value = categoryDetailsData['data']['variants']['size'];
        sizeList.value = size.value.split(',');
        sizeDropdownValue.value = sizeList[0];
        print("Size :: ${sizeList}");
      }
      // print("L = ${data.toString()}");
      // print("List :: => ${}");
      // }
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }

  //! Add Data into the Cart ..

  Future addToCart(clientId, productId, productQuantity, productPoints,
      productTitle, productImage) async {
    //! Here check the same client and productList empty ...
    items.value = await DataBaseHelper.dataBaseHelper.fetchProduct();

    if (items.length == 0) {
      var sameClient = await DataBaseHelper.dataBaseHelper.insert({
        DataBaseHelper.clientId: clientId,
        DataBaseHelper.productId: productId,
        DataBaseHelper.productQuantity: productQuantity,
        DataBaseHelper.productPoints: productPoints,
        DataBaseHelper.productTitle: productTitle,
        DataBaseHelper.productImage: productImage,
      });
      print("This is reposne for SQFLITE  :: ${sameClient}");
      ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
        SnackBar(
          content:
              Text(textAlign: TextAlign.center, "Product added to the card"),
          backgroundColor: AppColors.txtScanProductColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
        ),
      );
      return sameClient;
    } else {
      currentClientID = items[0]['clientId'];
      if (currentClientID == clientId) {
        var sameClient = await DataBaseHelper.dataBaseHelper.insert({
          DataBaseHelper.clientId: clientId,
          DataBaseHelper.productId: productId,
          DataBaseHelper.productQuantity: productQuantity,
          DataBaseHelper.productPoints: productPoints,
          DataBaseHelper.productTitle: productTitle,
          DataBaseHelper.productImage: productImage,
        });
        print("This is reposne for SQFLITE  :: ${sameClient}");
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
          SnackBar(
            content:
                Text(textAlign: TextAlign.center, "Product added to the card"),
            backgroundColor: AppColors.txtScanProductColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
          ),
        );
        return sameClient;
      } else {
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
          SnackBar(
            content: Text(
              textAlign: TextAlign.center,
              'You Can not add different client product',
            ),
            backgroundColor: AppColors.txtErrorTxtColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
          ),
        );
        print("You can't add the Product");
      }
    }

    // return false;
  }

  //! iS Check ..

  @override
  void onInit() {
    getCategoryDetails();
    CartController();
    super.onInit();
  }
}
