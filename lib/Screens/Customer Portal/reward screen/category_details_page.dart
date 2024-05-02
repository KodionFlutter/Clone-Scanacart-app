import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/category_details_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_appbar_widget.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
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
    final cartController = Get.put(CartController());

    return CommonAppbar(
        clientName: '',
        clientId: clientId,
        title: "Product Details",
        body: Obx(
          () => categoryDeController.productTitle.value.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ScrollConfiguration(
                  behavior: CommonScrollBehaveWidget(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 20),
                        CarouselSlider.builder(
                          itemCount:
                              categoryDeController.deatilsImageList.length,
                          options: CarouselOptions(
                            animateToClosest: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            height: AppConstant.size.height * 0.40,
                            enlargeCenterPage: true,
                            enableInfiniteScroll:
                                categoryDeController.deatilsImageList.length ==
                                        1
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
                                  height: AppConstant.size.height * 0.40,
                                  fit: BoxFit.contain,
                                  imageUrl: categoryDeController
                                      .deatilsImageList[index]['image_path'],
                                  placeholder: (context, url) {
                                    return const Center(
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
                                              color: Colors.black,
                                              fontSize: 10)),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: AppConstant.size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: categoryDeController.deatilsImageList
                              .map((categoryImages) {
                            int index = categoryDeController.deatilsImageList
                                .indexOf(categoryImages);
                            return Padding(
                              padding: const EdgeInsets.only(left: 1, right: 1),
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
                            categoryDeController.productTitle.value,
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
                                    text:
                                        "${categoryDeController.rewardPoints}",
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
                        // categoryDeController.colorList.isNotEmpty
                        //     ? Padding(
                        //         padding: EdgeInsets.only(
                        //             left: AppConstant.size.width * 0.03),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Color : ",
                        //               style: TextStyle(
                        //                   color: AppColors.blackColor,
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //             Obx(() => SizedBox(
                        //                   height: 40,
                        //                   width: 150,
                        //                   child: DropdownButtonFormField(
                        //                       decoration: const InputDecoration(
                        //                           enabled: true,
                        //                           // filled: true,
                        //                           border: OutlineInputBorder(),
                        //                           contentPadding:
                        //                               EdgeInsets.symmetric(
                        //                                   vertical: 10,
                        //                                   horizontal: 5)),
                        //                       // isExpanded: true,
                        //                       autovalidateMode: AutovalidateMode
                        //                           .onUserInteraction,
                        //                       isDense: true,
                        //                       validator: (value) {},
                        //                       value: categoryDeController
                        //                               .colorDropdownvalue
                        //                               .value
                        //                               .isEmpty
                        //                           ? null
                        //                           : categoryDeController
                        //                               .colorDropdownvalue.value
                        //                               .toString(),
                        //                       items: [
                        //                         ...categoryDeController
                        //                             .colorList
                        //                             .map((element) {
                        //                           return DropdownMenuItem(
                        //                               enabled: true,
                        //                               value: element,
                        //                               child: Text(
                        //                                   element.toString()));
                        //                         }),
                        //                       ],
                        //                       onChanged: (newValue) {
                        //                         categoryDeController
                        //                                 .colorDropdownvalue
                        //                                 .value =
                        //                             newValue.toString();
                        //                         print(
                        //                             "Value is :: ${categoryDeController.colorDropdownvalue.value}");
                        //                       }),
                        //                 ))
                        //           ],
                        //         ),
                        //       )
                        //     : const SizedBox(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: categoryDeController.variants.entries
                              .map<Widget>((variantEntry) {
                            List<String> list = variantEntry.value.split(",");
                            // Default value for the DropdownButton
                            var defaultValue;
                            list.forEach((element) {
                              defaultValue = element;
                            });
                            categoryDeController.selectedVariants.putIfAbsent(
                                variantEntry.key, () => defaultValue);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    variantEntry.key.isNotEmpty
                                        ? '${variantEntry.key[0].toUpperCase()}${variantEntry.key.substring(1)}'
                                        : variantEntry.key,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  variantEntry.value == "" &&
                                          variantEntry.value == null
                                      ? SizedBox()
                                      : SizedBox(
                                          width: 80,
                                          child: DropdownButton<String>(
                                            value: categoryDeController
                                                    .selectedVariants[
                                                variantEntry.key],
                                            dropdownColor: Colors.white,
                                            style:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(Icons.arrow_drop_down,
                                                color: Colors.black),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.white,
                                            ),
                                            onChanged: (String? newValue) {
                                              categoryDeController
                                                      .selectedVariants[
                                                  variantEntry.key] = newValue;
                                            },
                                            items: list
                                                .map<DropdownMenuItem<String>>(
                                              (variantOption) {
                                                return DropdownMenuItem<String>(
                                                  value: variantOption,
                                                  child: Text(variantOption),
                                                );
                                              },
                                            ).toList(),
                                            isExpanded: true,
                                          ),
                                        ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: AppConstant.size.height * 0.01),
                        // categoryDeController.sizeList.isNotEmpty
                        //     ? Padding(
                        //         padding: EdgeInsets.only(
                        //             left: AppConstant.size.width * 0.03),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Size   : ",
                        //               style: TextStyle(
                        //                   color: AppColors.blackColor,
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //             Obx(() => SizedBox(
                        //                   height: 40,
                        //                   width: 150,
                        //                   child: DropdownButtonFormField(
                        //                       decoration: const InputDecoration(
                        //                           enabled: true,
                        //                           // filled: true,
                        //                           border: OutlineInputBorder(),
                        //                           contentPadding:
                        //                               EdgeInsets.symmetric(
                        //                                   vertical: 10,
                        //                                   horizontal: 5)),
                        //                       // isExpanded: true,
                        //                       autovalidateMode: AutovalidateMode
                        //                           .onUserInteraction,
                        //                       isDense: true,
                        //                       validator: (value) {},
                        //                       value: categoryDeController
                        //                               .sizeDropdownValue.isEmpty
                        //                           ? null
                        //                           : categoryDeController
                        //                               .sizeDropdownValue
                        //                               .toString(),
                        //                       items: [
                        //                         ...categoryDeController.sizeList
                        //                             .map((element) {
                        //                           return DropdownMenuItem(
                        //                               enabled: true,
                        //                               value: element,
                        //                               child: Text(
                        //                                   element.toString()));
                        //                         }),
                        //                       ],
                        //                       onChanged: (newValue) {
                        //                         categoryDeController
                        //                                 .sizeDropdownValue
                        //                                 .value =
                        //                             newValue.toString();
                        //                         print(
                        //                             "Value is :: ${categoryDeController.sizeDropdownValue.value}");
                        //                       }),
                        //                 ))
                        //           ],
                        //         ),
                        //       )
                        //     : const SizedBox(),
                        SizedBox(height: AppConstant.size.height * 0.01),
                        // Display the Size :
                        const SizedBox(height: 20),
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
                            data: categoryDeController.productDescription.value,
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

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => ElevatedButton(
              onPressed: categoryDeController.productTitle.value.isEmpty
                  ? null
                  : () async {
                      if (categoryDeController.stockQuantity.value == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              textAlign: TextAlign.center,
                              "Product is Out of Stock",
                            ),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                          ),
                        );
                      } else {
                        // Map<String, dynamic> variants = {
                        //   "color":
                        //       "${categoryDeController.colorDropdownvalue.value}",
                        //   "size":
                        //       "${categoryDeController.sizeDropdownValue.value}"
                        // };

                        print(
                            "Size :: ${categoryDeController.sizeDropdownValue.value}");
                        // Get.to(CartPage());
                        await categoryDeController.addToCart({
                          DataBaseHelper.clientId: clientId,
                          DataBaseHelper.productId: productId,
                          DataBaseHelper.productQuantity:
                              categoryDeController.sendProductQuantity.value,
                          DataBaseHelper.variants:
                              categoryDeController.selectedVariants,
                          DataBaseHelper.productImage:
                              categoryDeController.productImage.value,
                          DataBaseHelper.productTitle:
                              categoryDeController.productTitle.value,
                          DataBaseHelper.productPoints:
                              categoryDeController.rewardPoints.value,
                          DataBaseHelper.variantId: categoryDeController.varId ?? "0",
                          DataBaseHelper.categoryId:
                              categoryDeController.categoryId.value
                        });

                        cartController.refreshItems();
                      }
                    },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: categoryDeController.productTitle.value.isEmpty
                    ? Colors.black12
                    : Colors.blue,
                fixedSize: Size(
                    AppConstant.size.width, AppConstant.size.height * 0.07),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  color: AppColors.txtWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ));
  }
}
