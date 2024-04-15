import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Customer%20Portal/authentication/signin%20screen/customer_login_page.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/controller/scan_nfc_controller.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/client_login_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/promo_code_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/reward_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/scan_product_btn_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/verify_button_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

import 'pages/ready_to_scan_page.dart';
import 'widget/nfc_enable_error_dailog_widget.dart';

class ScanNFCScreen extends StatelessWidget {
  ScanNFCScreen({super.key});

  final scanNfcController = Get.put(ScanNFCController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: AppColors.linearGradientColor),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // This is profile and reward section
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! Calling here reward widget
                RewardWidget(onTap: () {
                  Get.to(CustomerLoginPage());
                }),
                //! Calling Client Login section
                ClientLoginWidget(onTap: () {}),
              ],
            ),
          ),

          //! Show Scanacart Text
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text('Scanacart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.txtWhiteColor,
                  fontSize: 32,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                )),
          ),

          //! Showing here roted logo
          const SizedBox(height: 20),
          Image.asset("assets/images/imgpsh_fullsize_anim.gif",
              height: 180, width: 180),
          const SizedBox(height: 20),
          //!
          const Text(
            'Protect Your Brand',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
          const Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Welcome back to Scanacart!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          //! Card
          Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 0),
            child: Container(
                width: AppConstant.size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                          scanNfcController.selected.value =
                              !scanNfcController.selected.value;
                          scanNfcController.promoCode.value =
                              scanNfcController.promoCodeController.value.text;
                          scanNfcController.getEmployee(scanNfcController.promoCode.value);
                        }
                      }),
                      //! This is OR section ..
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFDDDDDD)),
                              ),
                            ),
                            Text(
                              'Or',
                              style: TextStyle(
                                color: AppColors.txtBlackColor,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: AppColors.greyBackgroundColor)),
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
          // Here showing the App Versions..
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 5),
            child: Text(
              "v.9.0.4",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: AppColors.txtWhiteColor,
                  fontSize: 12,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    ));
  }
}
