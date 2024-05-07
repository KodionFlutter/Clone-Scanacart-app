import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Models/category_details_model.dart';
import 'package:scan_cart_clone/Models/save_data_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CategoryDetailsController extends GetxController {
  final int productId;
  final int clientId;
  final String clientName;

  CategoryDetailsController({
    required this.productId,
    required this.clientId,
    required this.clientName,
  });

  //! Variable declare
  CategoryDetailsModel categoryDetailsModel = CategoryDetailsModel();
  SaveData saveData = SaveData();
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
  var categoryId = ''.obs;

  RxInt currentImageIndex = 0.obs;
  var colorDropdownvalue = ''.obs;
  var sizeDropdownValue = ''.obs;

  var stockQuantity = 0.obs;
  var sendProductQuantity = 1.obs;
  var items = [].obs;
  var currentClientID;
  var selectedVariants = {}.obs;
  var variants;
  int? varId;
  var productQuantity = 0.obs;

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
        categoryId.value = categoryDetailsData['data']['category_id'];
        productTitle.value = categoryDetailsData['data']['product_title'];
        // saveData.productName = categoryDetailsData['data']['product_title'];
        print("PT :: ${productTitle.value}");
        rewardPoints.value = categoryDetailsData['data']['reward_points'];
        print("RE :: ${rewardPoints.value}");
        deatilsImageList.value = categoryDetailsData['data']['images'];
        print("Ima :: ${deatilsImageList.length}");
        stockQuantity.value = categoryDetailsData['data']['stock_quantity'];
        print("The total Stock Qunatity is :: ${stockQuantity}");
        productImage.value = categoryDetailsData['data']['product_image'];
        //! make two variable -> variantsKey , variantsValue,
        variants = categoryDetailsData['data']['variants'];
        print("Variants : $variants");
        variantsData.value = categoryDetailsData['data']['variantsData'];
        print("variantsData :=>  $variantsData");
        // if (variants.isEmpty) {
        //   variants;
        // } else {}
        // print("Variants : ${variants.isEmpty}");
        // var variantsKey = [].obs;
        // var variantsValue = [].obs;
        //
        // variantsKey = variants.keys.forEach((key) {
        //   variantsKey.value = key;
        //   print("Key : $key");
        // });
        // print("keys : $variantsKey");
        //
        // variantsValue = variants.values.forEach((values) {
        //   print("value : $values");
        // });
        // print("variantsValue : $variantsValue");
      }
      ;

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

      // print("L = ${data.toString()}");
      // print("List :: => ${}");
      // }
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }

  //! Add Data into the Cart ..

  Future addToCart(Map<String, dynamic> data) async {
    //! Here check the sSame client and productList empty ...
    items.value = await DataBaseHelper.dataBaseHelper.fetchProduct();
    // var sameClient = await DataBaseHelper.dataBaseHelper.insert(data);
    // print("Insert Data :: $sameClient");
    // if (variantsData.isNotEmpty) {
    //   getVarId();
    // }
    print("Response of SQFLite : ${items.length}");
    if (items.length == 0 || items.isEmpty) {
      var sameClient = await DataBaseHelper.dataBaseHelper.insert(data);
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
      currentClientID = items[0]['client_id'];
      if (currentClientID == clientId) {
        var sameClient = await DataBaseHelper.dataBaseHelper.insert(data);
        print("This is response for sqfLite  :: ${sameClient}");
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
          SnackBar(
            content: const Text(
                textAlign: TextAlign.center, "Product added to the card"),
            backgroundColor: AppColors.txtScanProductColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
          ),
        );
        return sameClient;
      } else {
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
          SnackBar(
            content: const Text(
              textAlign: TextAlign.center,
              'You Can not add different client product',
            ),
            backgroundColor: AppColors.txtErrorTxtColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
          ),
        );
        print("You Can not add different client product");
      }
    }
  }

  //! iS Check ..
  getVarId() {
    for (int i = 0; i < variantsData.length; i++) {
      if (variantsData[i]['color'] == selectedVariants['color']) {
        if (variantsData[i]['size'] == selectedVariants['size']) {
          varId = variantsData[i]['variant_id'];
          print("object%65675===>${varId}");
          break;
        } else if (variantsData[i]['size'] == null ||
            variantsData[i]['size'] == "") {
          varId = variantsData[i]['variant_id'];
          print("object%65675===>${varId}");
          break;
        }
      } else if (variantsData[i]['color'] == null ||
          variantsData[i]['color'] == "" &&
              variantsData[i]['size'] == selectedVariants['size']) {
        varId = variantsData[i]['variant_id'];
        break;
      }
    }
  }

  @override
  void onInit() {
    getCategoryDetails();
    CartController();
    super.onInit();
  }
}
