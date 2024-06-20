import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Common/widgets/common_web_view.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signin%20screen/customer_login_page.dart';
import 'package:scan_cart_clone/Screens/product%20screen/controller/product_controller.dart';
import 'package:scan_cart_clone/Screens/product%20screen/widget/app_bar_widget.dart';
import 'package:scan_cart_clone/Screens/product%20screen/widget/display_videos_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductScreen extends StatelessWidget {
  final EmployeeDataModel responseData;
  final String serialNumber;
  final String? couponCode;

  const ProductScreen({
    super.key,
    required this.responseData,
    required this.serialNumber,
    this.couponCode,
  });

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController(
      serialNumber: serialNumber,
      responseData: responseData,
    ));
    log("Video initlized => ${productController.videoPlayerController?.value.isInitialized}");

    return PopScope(
      onPopInvoked: (d) {
        productController.videoPlayerController!.pause();
        productController.videoPlayerController!.setVolume(0);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: AppConstant.size.width,
          height: AppConstant.size.height,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Stack(
            children: [
              GetBuilder<ProductController>(builder: (_) {
                if (productController.videoUrl.value.endsWith("mp4")) {
                  return productController
                          .videoPlayerController!.value.isInitialized
                      ? SizedBox(
                          width: AppConstant.size.width,
                          height: AppConstant.size.height,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Here display the video
                              // productController.getBOXFitted( productController.videoPlayerController)
                              DisplayVideoWidget(
                                controller:
                                    productController.videoPlayerController!,
                              ),
                            ],
                          ),
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              left: (AppConstant.size.width - 180) / 2,
                              top: (AppConstant.size.height - 180) / 2.4,
                              // Center vertically
                              child: Image.asset(
                                "assets/splash/img_splash_anim.gif",
                                width: 180,
                                height: 180,
                              ),
                            )
                          ],
                        );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 130),
                      child: SizedBox(
                        height: 220,
                        width: AppConstant.size.width / 1.3,
                        child: productController.logoPath.value.isEmpty
                            ? CachedNetworkImage(
                                imageUrl: productController.logoPath.value,
                                fit: BoxFit.contain,
                                placeholder: (context, url) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        left:
                                            (AppConstant.size.width - 180) / 2,
                                        top: (AppConstant.size.height - 180) /
                                            2.4,
                                        // Center vertically
                                        child: Image.asset(
                                          "assets/images/cropscana.png",
                                          width: 180,
                                          height: 180,
                                        ),
                                      )
                                    ],
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Material(
                                    color: Colors.transparent.withOpacity(0.8),
                                    child: const Center(
                                      child: Text('Could\'t load image',
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22)),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  );
                }
              }),
              // Obx(() {
              //
              // }),
              Positioned(
                top: 30,
                right: 0,
                left: 10,
                child: Row(
                  children: [
                    Expanded(
                        child: Obx(
                      () => AppbarWidget(
                        imagePath: productController.logoPath.value,
                      ),
                    )),
                  ],
                ),
              ),
              Positioned(
                bottom: 6,
                right: 10,
                left: 10,
                child: Obx(
                  () => Container(
                    width: AppConstant.size.width / 1.1,
                    padding: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white10,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 10, top: 15),
                      child: Column(
                        children: [
                          Text(
                            productController.clientName.value.isNotEmpty
                                ? 'Authentic ${productController.clientName.value} Product'
                                : 'Authentic Product',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.blackBackgroundColor,
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (productController.logoPath.value.isEmpty)
                            const SizedBox(height: 10)
                          else
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                height: 90,
                                width: AppConstant.size.width * 0.7,
                                child: CachedNetworkImage(
                                  imageUrl: productController.logoPath.value,
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) {
                                    return Material(
                                      color:
                                          Colors.transparent.withOpacity(0.8),
                                      child: const Center(
                                        child: Text('Could not load image',
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          const SizedBox(height: 5),
                          if (couponCode != null)
                            Text(
                              "Serial #$couponCode".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.blackBackgroundColor,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          else
                            Text(
                              "Serial #${productController.rewardPoint.value}"
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.blackBackgroundColor,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 10),
                          CommonButtonWidget(
                            isEnabled: true,
                            onPressed: () {
                              productController.videoPlayerController!.pause();
                              productController.videoPlayerController!
                                  .setVolume(0.0);
                              Get.back();
                              Get.to(CommonWebView(
                                title: productController.clientName.value,
                                url: productController.clientUrl.value,
                              ));
                            },
                            buttonTxt: productController
                                    .clientName.value.isEmpty
                                ? 'About'
                                : "About ${productController.clientName.value}",
                            btnHeight: AppConstant.size.height * 0.06,
                            btnWidth: AppConstant.size.width,
                            // colors: Colors.black,
                            linearGradient: AppColors.verifyLinearGradientColor,
                            txtColor: AppColors.txtWhiteColor,
                          ),
                          const SizedBox(height: 10),
                          (productController.rewardsValue.value.toString() !=
                                      "0" ||
                                  productController.rewardsValue.value
                                          .toString() !=
                                      'null')
                              ? CommonButtonWidget(
                                  isEnabled: true,
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var id = prefs.getInt("customer_id");
                                    if (id != null) {
                                      productController.showPopUp();
                                      // Get.off(RewardScreen(
                                      //   customerId: id,
                                      // ));
                                      Get.off(FloatingButtonPage(
                                        customerId: id,
                                        state: true,
                                      ));

                                      productController.videoPlayerController!
                                          .pause();
                                    } else {
                                      Get.off(CustomerLoginPage());
                                      productController.videoPlayerController!
                                          .pause();
                                    }
                                  },
                                  buttonTxt: "Get Rewards ",
                                  btnHeight: AppConstant.size.height * 0.06,
                                  btnWidth: AppConstant.size.width,
                                  colors: Colors.lightBlueAccent.shade200,
                                  txtColor: AppColors.txtWhiteColor,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
