import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Models/view_category_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/category_details_controller.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CategoryDetailsPage extends StatelessWidget {
  final int productId;
  final int clientId;

  CategoryDetailsPage({
    super.key,
    required this.productId,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context) {
    final categoryDeController = Get.put(
        CategoryDetailsController(productId: productId, clientId: clientId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Product Details",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppConstant.size.width * 0.03),
            child: Icon(
              Icons.shopping_cart_rounded,
            ),
          )
        ],
      ),
      body: Obx(
        () => categoryDeController.deatilsImageList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CarouselSlider.builder(
                      itemCount: categoryDeController.deatilsImageList.length,
                      options: CarouselOptions(
                        height: AppConstant.size.height * 0.45,
                        enableInfiniteScroll:
                            categoryDeController.deatilsImageList.length == 1
                                ? false
                                : true,
                        viewportFraction: 1,
                        onPageChanged: (i, _) {
                          categoryDeController.currentImageIndex.value = i;
                        },
                      ),
                      itemBuilder: (BuildContext context, int index, j) {
                        return Center(
                          child: CachedNetworkImage(
                            width: 500,
                            height: 300,
                            fit: BoxFit.contain,
                            imageUrl: categoryDeController
                                .deatilsImageList[index].imagePath,
                            placeholder: (context, url) {
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Text('Could\'t load image',
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10)),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: categoryDeController.deatilsImageList
                          .map((categoryImages) {
                        int index = categoryDeController.deatilsImageList
                            .indexOf(categoryImages);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                categoryDeController.currentImageIndex.value ==
                                        index
                                    ? Colors.blue
                                    : Colors.black12,
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
                      child: Text(
                        "${categoryDeController.categoryDetailsModel.data?.productTitle}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
                      child: Text(
                        "Price: ${categoryDeController.categoryDetailsModel.data?.rewardPoints} Ponts",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                      endIndent: AppConstant.size.width * 0.03,
                      indent: AppConstant.size.width * 0.03,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
                      child: Text(
                        "${categoryDeController.categoryDetailsModel.data?.productTitle}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            fixedSize:
                Size(AppConstant.size.width, AppConstant.size.height * 0.09),
          ),
          child: Text(
            "Add to Cart",
            style: TextStyle(
              color: AppColors.txtWhiteColor,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
