import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/custom_container.dart';
import 'package:scan_cart_clone/Common/widgets/shimmer_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/view_category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/category_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_pageview_widget.dart';
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
          backgroundColor: AppColors.whiteBackgroundColor,
          foregroundColor: AppColors.blackColor,
          elevation: 0,
          title: Center(
              child: Text(
            "$clientName",
          )),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppConstant.size.width * 0.03),
              child: Icon(
                Icons.shopping_cart_rounded,
              ),
            )
          ],
        ),
        body: Obx(() {
          if (redeemController.categoryList.isEmpty) {
            return ShimmerWidget(
                child: Stack(
              children: [
                Expanded(
                  child: CustomContainer(
                    height: AppConstant.size.height,
                    width: AppConstant.size.width,
                    radius: 0,
                  ),
                ),
                Positioned(
                  top: AppConstant.size.height * 0.03,
                  left: AppConstant.size.width * 0.05,
                  child: CustomContainer(
                    height: AppConstant.size.height*0.02,
                    width: AppConstant.size.width*0.5,
                    radius: 0,
                  ),
                ),
                Positioned(
                  top: AppConstant.size.height * 0.06,
                  left: AppConstant.size.width * 0.05,
                  child: CustomContainer(
                    height: AppConstant.size.height*0.02,
                    width: AppConstant.size.width*0.5,
                    radius: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: AppConstant.size.height * 0.03),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomContainer(
                      height:  AppConstant.size.height*0.08,
                      width: AppConstant.size.width*0.7,
                      radius: 20,
                    )
                  ),
                )
              ],
            ));
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
                        categoryName:
                            redeemController.categoryList[index].categoryName!,
                        clientName: clientName,
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
