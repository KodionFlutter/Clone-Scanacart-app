import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/view_category_controller.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class ViewCategoryPage extends StatelessWidget {
  final int categoryId;
  final int clientId;

  const ViewCategoryPage({
    super.key,
    required this.categoryId,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context) {
    final viewCategoryController = Get.put(ViewCategoryController(
      categoryId: categoryId,
      clientId: clientId,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteBackgroundColor,
        title: Text("Product Details"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppConstant.size.width * 0.03),
            child: Icon(
              Icons.shopping_cart_rounded,
              color: AppColors.whiteBackgroundColor,
            ),
          )
        ],
      ),
      body: Container(
        height: AppConstant.size.height * 1,
        width: AppConstant.size.width,
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
      ),
    );
  }
}
