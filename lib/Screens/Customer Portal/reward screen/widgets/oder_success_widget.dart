import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_button.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderSuccessWidget extends StatelessWidget {
  final int customerId;
  final VoidCallback onPressed;

  const OrderSuccessWidget(
      {super.key, required this.customerId, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: AppConstant.size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //! Here i show the Image of booking ..
            SizedBox(height: 10),
            CircleAvatar(
              maxRadius: 40,
              backgroundColor: Colors.black12,
              child: Image.asset(
                "assets/images/order.png",
                height: 60,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your order has been placed!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for shopping with us.',
              style: TextStyle(fontSize: 15, color: AppColors.blackColor),
            ),
            SizedBox(height: 20),

            //! Here we make a button ..
            CommonButtonWidget(
              onPressed: onPressed,
              buttonTxt: "Ok".toUpperCase(),
              btnHeight: 40,
              btnWidth: 120,
              txtColor: AppColors.whiteBackgroundColor,
              isEnabled: true,
              colors: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
