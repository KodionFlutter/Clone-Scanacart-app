import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signin%20screen/customer_login_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signup%20screen/customer_signup_screen.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/reward_screen.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/controller/scan_nfc_controller.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/client_login_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/promo_code_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/reward_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/scan_product_btn_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/verify_button_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanNFCScreen extends StatelessWidget {
  ScanNFCScreen({super.key});

  final scanNfcController = Get.put(ScanNFCController());

  @override
  Widget build(BuildContext context) {
    final height = AppConstant.size.height;
    final width = AppConstant.size.width;
    return PopScope(
      canPop: true,
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(gradient: AppColors.linearGradientColor),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // This is Custom profile and reward section
            FadeTransition(
              opacity: scanNfcController.animationController,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! Calling here reward widget♥
                    RewardWidget(onTap: () async {
                      //Save the customer id
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var id = prefs.getInt("customer_id");
                      scanNfcController.promoCodeController.value.clear();
                      if (id != null) {
                        Get.to(RewardScreen(customerId: id));
                      } else {
                        Get.to(CustomerLoginPage());
                      }
                    }),
                    //! Calling Client Login section
                    ClientLoginWidget(onTap: () {}),
                  ],
                ),
              ),
            ),

            FadeTransition(
              opacity: scanNfcController.dashanimation,
              child: Column(
                children: [
                  //! Show Scanacart Text
                  Text('Scanacart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.txtWhiteColor,
                        fontSize: AppConstant.size.width * 0.09,
                        fontWeight: FontWeight.bold,
                      )),

                  //! Showing here Gif logo image
                  SizedBox(height: AppConstant.size.height * 0.02),
                  Image.asset(
                    "assets/images/imgpsh_fullsize_anim.gif",
                    height: height * 0.2,
                    width: width * 0.4,
                  ),
                  SizedBox(height: AppConstant.size.height * 0.02),

                  Text(
                    'Protect Your Brand',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstant.size.width * 0.08,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.02),
                    child: Text(
                      'Welcome back to Scanacart!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //! Card
            FadeTransition(
              opacity: scanNfcController.textanimation,
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: width * 0.04,
                    right: width * 0.04,
                    bottom: 0),
                child: Container(
                    width: AppConstant.size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      color: AppColors.whiteBackgroundColor,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          // PromoCode Text Filed section ..
                          PromoCodetxtFeildWidget(),
                          //! This is VerifyButton section ..
                          VerifyButtonWidget(onPressed: () {
                            scanNfcController.NFCscan(false);
                            if (scanNfcController
                                .promoCodeController.value.text.isEmpty) {
                              scanNfcController.NFCscan(true);
                              showMessage(
                                "Please enter a product code.",
                                AppColors.whiteBackgroundColor,
                              );
                            } else {
                              // FocusScope.of(context).unfocus();

                              scanNfcController.selected.value =
                                  !scanNfcController.selected.value;
                              scanNfcController.promoCode.value =
                                  scanNfcController
                                      .promoCodeController.value.text;
                              scanNfcController.getEmployee(
                                  scanNfcController.promoCode.value);
                            }
                          }),

                          //! This is OR section ..
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.02,
                                left: width * 0.025,
                                right: width * 0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                        color: AppColors.orTxtColor),
                                  ),
                                ),
                                Text(
                                  'Or',
                                  style: TextStyle(
                                      color: AppColors.txtBlackColor,
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(
                                  child: Container(
                                      height: 1,
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.greyBackgroundColor)),
                                )
                              ],
                            ),
                          ),
                          //! This is Scan ProductButton Section
                          ScanProductBtnWidget(
                              onPressed: () => scanNfcController.tagRead()),
                        ],
                      ),
                    )),
              ),
            ),
            // Here showing the App Versions..
            FadeTransition(
              opacity: scanNfcController.textanimation,
              child: Padding(
                padding:
                    EdgeInsets.only(right: width * 0.04, top: height * 0.01),
                child: Text(
                  "v.9.0.4",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppColors.txtWhiteColor,
                      fontSize: 12,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
