import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Models/view_category_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/category_details_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_drop_down_widget.dart';
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
        () => categoryDeController.productTitle.value.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ScrollConfiguration(
                behavior: CommonScrollBehaveWidget(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      CarouselSlider.builder(
                        itemCount: categoryDeController.imgList.length,
                        options: CarouselOptions(
                          animateToClosest: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.9,
                          height: AppConstant.size.height * 0.45,
                          enlargeCenterPage: true,
                          enableInfiniteScroll:
                              categoryDeController.imgList.length == 1
                                  ? false
                                  : true,
                          onPageChanged: (i, _) {
                            categoryDeController.currentImageIndex.value = i;
                          },
                        ),
                        itemBuilder: (BuildContext context, int index, j) {
                          return Center(
                            child: Hero(
                              tag: productId,
                              child: CachedNetworkImage(
                                width: AppConstant.size.width,
                                // height: 300,
                                fit: BoxFit.contain,
                                imageUrl: categoryDeController.imgList![index]
                                    .toString(),
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
                            ),
                          );
                        },
                      ),
                      SizedBox(height: AppConstant.size.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            categoryDeController.imgList.map((categoryImages) {
                          int index = categoryDeController.imgList
                              .indexOf(categoryImages);
                          return Padding(
                            padding: EdgeInsets.only(left: 1, right: 1),
                            child: Container(
                              width: categoryDeController
                                          .currentImageIndex.value ==
                                      index
                                  ? 15.0
                                  : 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(10),
                                color: categoryDeController
                                            .currentImageIndex.value ==
                                        index
                                    ? Colors.blue
                                    : Colors.black12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: AppConstant.size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.size.width * 0.03),
                        child: Text(
                          "${categoryDeController.productTitle.value}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstant.size.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.size.width * 0.03),
                        child: RichText(
                          text: TextSpan(
                            text: "Points : ",
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                  text: "${categoryDeController.rewardPoints}",
                                  style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                      //! display here the product variantsData
                      SizedBox(height: AppConstant.size.height * 0.01),
                      // Disply the Color :
                      categoryDeController.colorList.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: AppConstant.size.width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Color : ",
                                    style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Obx(() => SizedBox(
                                        height: 40,
                                        width: 150,
                                        child: CommonDropDownWidget(
                                          dropdownvalue: categoryDeController
                                              .colorDropdownvalue.value,
                                          valueList:
                                              categoryDeController.colorList,
                                        ),
                                      ))
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: AppConstant.size.height * 0.01),
                      categoryDeController.sizeList.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: AppConstant.size.width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Size   : ",
                                    style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Obx(() => SizedBox(
                                        height: 40,
                                        width: 150,
                                        child: CommonDropDownWidget(
                                          dropdownvalue: categoryDeController
                                              .sizeDropdownValue.value,
                                          valueList:
                                              categoryDeController.sizeList,
                                        ),
                                      ))
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: AppConstant.size.height * 0.01),
                      // Display the Size :
                      SizedBox(height: 20),
                      Divider(
                        height: 2,
                        color: Colors.grey,
                        endIndent: AppConstant.size.width * 0.03,
                        indent: AppConstant.size.width * 0.03,
                      ),
                      //! Product Description ..

                      SizedBox(height: AppConstant.size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.size.width * 0.03),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstant.size.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.size.width * 0.03),
                        child: Html(
                          shrinkWrap: true,
                          data:
                              "${categoryDeController.productDescription.value}",
                          style: {
                            "*": Style(
                              wordSpacing: 1.0,
                              textAlign: TextAlign.start,
                              fontSize: FontSize(16, Unit.px),
                              color: AppColors.blackColor,
                              padding: HtmlPaddings.only(bottom: 5),
                            ),
                          },
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            fixedSize:
                Size(AppConstant.size.width, AppConstant.size.height * 0.07),
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