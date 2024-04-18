import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/view_category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/category_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/widgets/common_pageview_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CategoryPage extends StatelessWidget {
  final int clientId;
  final String clientName;

  const CategoryPage(
      {super.key, required this.clientId, required this.clientName});

  @override
  Widget build(BuildContext context) {
    final redeemController = Get.put(CategoryController(clientId: clientId));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          foregroundColor: AppColors.whiteBackgroundColor,
          title: Center(
              child: Text(
            "$clientName",
            // style: TextStyle(color: AppColors.txtWhiteColor),
          )),
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
        body: Obx(() {
          if (redeemController.categoryList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return PageView.builder(
              itemCount: redeemController.categoryList.length,
              itemBuilder: (context, index) {
                return CommonPageViewWidget(
                  categoryName:
                      redeemController.categoryList[index].categoryName!,
                  categoryDescription:
                      redeemController.categoryList[index].categoryDescription!,
                  categoryImage:
                      redeemController.categoryList[index].categoryImage!,
                  onPressed: () {
                    Get.to(
                      ViewCategoryPage(
                        categoryId:
                            redeemController.categoryList[index].categoryId!,
                        clientId: clientId,
                      ),
                      transition: Transition.fadeIn,
                    );
                  },
                );
              },
              scrollDirection: Axis.vertical,
            );
          }
        }));
  }
}
