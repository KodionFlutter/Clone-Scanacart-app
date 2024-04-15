import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Customer%20Portal/authentication/otp%20verify%20screen/controller/otp_verify_controller.dart';
import 'package:scan_cart_clone/Customer%20Portal/widgets/common_TextField.dart';
import 'package:scan_cart_clone/Customer%20Portal/widgets/common_header_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OtpVerifyScreen extends StatelessWidget {

  OtpVerifyScreen({super.key});

  final otpController = Get.put(OTPVrifyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppConstant.size.height,
        width: AppConstant.size.width,
        decoration: BoxDecoration(
          gradient: AppColors.linearGradientColor,
        ),
        child: ListView(
          children: [
            //! Show the Scanacart Text .
            CommonHeaderWidget(
              title: 'Verify Your account',
              subtitle: '',
              voidCallback: () {
                Get.back();
              },
            ),
            //! OTP Field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CommonTxtFieldWidget(
                textEditController: otpController.otpVerifyController.value,
                textInputType: TextInputType.number,
                icons: Icons.lock,
                hinText: "Verification Code",
                preFixText: "",
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "Please enter verification code";
                  }
                },
              ),
            ),
            //! Login Buttoin ..
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 30, right: 30, top: 20),
              child: CommonButtonWidget(
                onPressed: () async {
                  if (otpController.otpVerifyController.value.text.isEmpty) {
                    showMessage("Error", AppColors.whiteBackgroundColor);
                  } else {
                    await otpController.verifyotp(
                        otpController.otpVerifyController.value.text);
                  }
                },
                buttonTxt: 'Verify',
                btnHeight: AppConstant.size.height * 0.07,
                btnWidth: AppConstant.size.width * 0.7,
                colors: AppColors.whiteBackgroundColor,
                txtColor: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
