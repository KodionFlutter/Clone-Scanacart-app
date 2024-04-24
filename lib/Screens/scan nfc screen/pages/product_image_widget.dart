import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Common/widgets/common_web_view.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signin%20screen/customer_login_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/reward_screen.dart';
import 'package:scan_cart_clone/Screens/product%20screen/controller/product_controller.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductImageWidget extends StatelessWidget {
  final EmployeeDataModel responseData;
  final String serialNumber;
  final String? couponCode;

  const ProductImageWidget({
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
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: AppConstant.size.width * 0.05,
            right: AppConstant.size.width * 0.05),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.all(
                  Radius.circular(AppConstant.size.width * 0.05))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cancel button
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0,
                        right: AppConstant.size.width * 0.04,
                        top: AppConstant.size.width * 0.04),
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.cancel_outlined,
                            size: AppConstant.size.height * 0.035)),
                  ),
                ],
              ),
              //! Error image
              CircleAvatar(
                backgroundColor: AppColors.whiteBackgroundColor,
                radius: AppConstant.size.height * 0.075,
                child: Image(
                    image: const AssetImage('assets/images/1error.png'),
                    width: AppConstant.size.width * 0.9,
                    height: AppConstant.size.height * 0.17),
              ),
              SizedBox(height: AppConstant.size.height * 0.02),

              const Material(
                color: Colors.transparent,
                child: Center(
                  child: Text("Authentic Product",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              // Product Image Logo ..
              SizedBox(height: AppConstant.size.height * 0.02),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: SizedBox(
                    height: AppConstant.size.height * 0.22,
                    width: AppConstant.size.width / 1.3,
                    child: productController.logoPath.value.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: productController.logoPath.value,
                            fit: BoxFit.contain,
                            placeholder: (context, url) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
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
                                          color: Colors.black, fontSize: 22)),
                                ),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              SizedBox(height: AppConstant.size.height * 0.02),

              //! Here are button for

              Padding(
                padding: EdgeInsets.only(
                    left: AppConstant.size.width * 0.03,
                    right: AppConstant.size.width * 0.03),
                child: CommonButtonWidget(
                  isEnabled: true,
                  onPressed: () {
                    Get.back();
                    Get.to(CommonWebView(
                      title: productController.clientName.value,
                      url: productController.clientUrl.value,
                    ));
                  },
                  buttonTxt: productController.clientName.value.isEmpty
                      ? 'About'
                      : "About ${productController.clientName.value}",
                  btnHeight: AppConstant.size.height * 0.07,
                  btnWidth: AppConstant.size.width,
                  // colors: Colors.black,
                  linearGradient: AppColors.verifyLinearGradientColor,
                  txtColor: AppColors.txtWhiteColor,
                ),
              ),
              const SizedBox(height: 10),
              (productController.rewardsValue.value.toString() != "0" ||
                      productController.rewardsValue.value.toString() != 'null')
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: AppConstant.size.width * 0.03,
                          right: AppConstant.size.width * 0.03),
                      child: CommonButtonWidget(
                        isEnabled: true,
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var id = prefs.getInt("customer_id");
                          if (id != null) {
                            productController.showPopUp();
                            Get.off(RewardScreen(
                              customerId: id,
                            ));

                            productController.videoPlayerController!.pause();
                          } else {
                            Get.off(CustomerLoginPage());
                            productController.videoPlayerController!.pause();
                          }
                        },
                        buttonTxt: "Get Rewards ",
                        btnHeight: AppConstant.size.height * 0.07,
                        btnWidth: AppConstant.size.width,
                        colors: Colors.lightBlueAccent.shade200,
                        txtColor: AppColors.txtWhiteColor,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
              if (couponCode != null)
                Material(
                  color: Colors.transparent,
                  child: Text(
                    "Serial #$couponCode".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.blackBackgroundColor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Material(
                  color: Colors.transparent,
                  child: Text(
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
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
