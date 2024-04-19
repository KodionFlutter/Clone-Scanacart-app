import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
        () => categoryDeController.productTitle.value.isEmpty
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
                          child: Hero(
                            tag: productId,
                            child: CachedNetworkImage(
                              width: AppConstant.size.width,
                              height: 300,
                              fit: BoxFit.contain,
                              imageUrl: categoryDeController
                                  .deatilsImageList[index]['image_path']
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
                      children: categoryDeController.deatilsImageList
                          .map((categoryImages) {
                        int index = categoryDeController.deatilsImageList
                            .indexOf(categoryImages);
                        return Container(
                          width: categoryDeController.currentImageIndex.value ==
                                  index
                              ? 15.0
                              : 8.0,
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
                    SizedBox(height: AppConstant.size.height * 0.03),
                    Padding(
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
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
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
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
                                Text("Color : "),
                               // DropdownButton<String>(
                               //   value: categoryDeController
                               //       .colorDropdownvalue.value,
                               //   icon: const Icon(Icons.keyboard_arrow_down),
                               //   // Array list of items
                               //   items: categoryDeController.colorList.value
                               //       .map<DropdownMenuItem<String>>((String items) {
                               //     return DropdownMenuItem<String>(
                               //       value: items,
                               //       child: Text(items),
                               //     );
                               //   }).toList(),
                               //   onChanged: (String? newValue) {
                               //     categoryDeController
                               //         .colorDropdownvalue.value = newValue!;
                               //   },
                               // ),
                               //  DropdownButton<String>(
                               //    value:categoryDeController.colorDropdownvalue.value,
                               //    onChanged: (String? newValue) {
                               //      categoryDeController.colorDropdownvalue.value = newValue!;
                               //    },
                               //    items: categoryDeController.colorList.map<DropdownMenuItem<String>>(
                               //          (String value) {
                               //        return DropdownMenuItem<String>(
                               //          value: value,
                               //          child: Text(value),
                               //        );
                               //      },
                               //    ).toList(),
                               //  ),
                              ],
                            ),
                          )
                        : SizedBox(),

                    categoryDeController.sizeList.value.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: AppConstant.size.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Size : "),
                                // DropdownButton(
                                //   value: categoryDeController.sizeDropdownValue.value,
                                //   isExpanded: false,
                                //   icon: const Icon(Icons.keyboard_arrow_down),
                                //   // Array list of items
                                //   items: categoryDeController.sizeList
                                //       .map((items) {
                                //     return DropdownMenuItem(
                                //       enabled: true,
                                //       onTap: () {},
                                //       value: items,
                                //       child: Text(items),
                                //     );
                                //   }).toList(),
                                //   onChanged: (newValue) {
                                //     categoryDeController.sizeDropdownValue.value = !newValue;
                                //   },
                                // ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: AppConstant.size.height * 0.01),
                    // Disply the Size :
                    // Padding(
                    //   padding:  EdgeInsets.only(left: AppConstant.size.width*0.03),
                    //   child: RichText(
                    //     text: TextSpan(
                    //       text: "Size : ",
                    //       style: TextStyle(
                    //           color: AppColors.blackColor,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w400),
                    //       children: [
                    //         TextSpan(
                    //             text:
                    //             "${categoryDeController.categoryDetailsModel.data!.variants!.color}",
                    //             style: TextStyle(color: AppColors.blackColor ,  fontSize: 14,
                    //                 fontWeight: FontWeight.w400)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
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
                      padding:
                          EdgeInsets.only(left: AppConstant.size.width * 0.03),
                      // child: Text(
                      //   "${categoryDeController.categoryDetailsModel.data?.productTitle}",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //     color: AppColors.blackColor,
                      //   ),
                      // ),
                      child: Html(
                        shrinkWrap: true,
                        data:
                            "${categoryDeController.productDescription.value}",
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
