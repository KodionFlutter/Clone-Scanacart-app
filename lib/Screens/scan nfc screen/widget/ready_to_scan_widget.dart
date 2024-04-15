import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class ReadyToScanWidget extends StatelessWidget {
  ReadyToScanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: AppColors.whiteBackgroundColor,
      insetPadding: const EdgeInsets.all(18),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Text(
                    'Ready to scan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.txtBlackColor,
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: SizedBox(
                  height: 90,
                  width: 120,
                  child: Image.asset(
                    "assets/images/impop.png",
                  ),
                ),
              ),
              SizedBox(
                width: 329,
                child: Text(
                  AppConstant.nfcText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.txtBlackColor,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 15),
                  child: SizedBox(
                      height: 49,
                      width: double.infinity,
                      child: CommonButtonWidget(
                        onPressed: () {
                          Get.back();
                        },
                        buttonTxt: 'Cancel',
                        btnHeight: AppConstant.size.height * 0.1,
                        btnWidth: AppConstant.size.width,
                        linearGradient: AppColors.verifyLinearGradientColor,
                        txtColor: AppColors.txtWhiteColor,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
