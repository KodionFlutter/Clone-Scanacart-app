import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Common/widgets/custom_container.dart';
import 'package:scan_cart_clone/Common/widgets/shimmer_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/cart_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/view_category_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_appbar_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_view_category_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category_details_page.dart';

class ViewCategoryPage extends StatelessWidget {
  final int categoryId;
  final int clientId;
  final String categoryName;
  final String clientName;

  const ViewCategoryPage({
    super.key,
    required this.categoryId,
    required this.clientId,
    required this.categoryName,
    required this.clientName,
  });

  @override
  Widget build(BuildContext context) {
    final viewCategoryController = Get.put(ViewCategoryController(
      categoryId: categoryId,
      clientId: clientId,
    ));
    return CommonAppbar(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setInt("BackFlag", 2);
        Get.to(CartPage(
          clientId: clientId,
          clientName: clientName,
        ));
      },
      clientId: clientId,
      clientName: clientName,
      title: clientName,
      body: Obx(() {
        if (viewCategoryController.isLoad.value == true) {
          return ShimmerWidget(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomContainer(
                  height: AppConstant.size.height * 0.02,
                  width: AppConstant.size.width * 0.5,
                  radius: 10,
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CommonScrollBehaveWidget(),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: AppConstant.size.height * 0.02,
                        crossAxisSpacing: AppConstant.size.width * 0.03,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              height: 150,
                              width: AppConstant.size.width,
                              radius: 10,
                            ),
                            SizedBox(height: AppConstant.size.width * 0.01),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: AppConstant.size.width * 0.03,
                                ),
                                child: CustomContainer(
                                  height: 20,
                                  width: AppConstant.size.width,
                                  radius: 10,
                                )),
                            SizedBox(height: AppConstant.size.width * 0.01),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: AppConstant.size.width * 0.03,
                                  bottom: 5),
                              child: CustomContainer(
                                height: 20,
                                width: 70,
                                radius: 10,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ],
          ));
        } else if (viewCategoryController.viewCategoryList.isEmpty) {
          return Column(
            children: [
              SizedBox(height: AppConstant.size.height * 0.1),
              Image.asset(
                "assets/images/record.webp",
                fit: BoxFit.contain,
                height: AppConstant.size.height * 0.3,
                width: AppConstant.size.width,
              ),
              SizedBox(height: AppConstant.size.height * 0.01),
              Text(
                "No ${categoryName} Found".toUpperCase(),
                style: TextStyle(
                    fontSize: AppConstant.size.height * 0.020,
                    fontWeight: FontWeight.bold),
              )
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppConstant.size.width * 0.04),
                child: Text(
                  "$categoryName",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CommonScrollBehaveWidget(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: AppConstant.size.height * 0.02,
                      crossAxisSpacing: AppConstant.size.width * 0.03,
                    ),

                    padding: EdgeInsets.all(8.0),
                    // padding around the grid
                    itemCount: viewCategoryController.viewCategoryList.length,
                    // total number of items
                    itemBuilder: (context, index) {
                      return CommonViewCategoryWidget(
                        categoryName: viewCategoryController.categoryName.value,
                        productRewardPoints: viewCategoryController
                            .viewCategoryList[index].productRewardPoints!,
                        productTitle: viewCategoryController
                            .viewCategoryList[index].productTitle!,
                        productImage: viewCategoryController
                            .viewCategoryList[index].productImage!,
                        product_id: viewCategoryController
                            .viewCategoryList[index].productId,
                        onTap: () {
                          Get.to(CategoryDetailsPage(
                            productId: viewCategoryController
                                .viewCategoryList[index].productId!,
                            clientId: clientId,
                            clientName: clientName,
                          ));
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
