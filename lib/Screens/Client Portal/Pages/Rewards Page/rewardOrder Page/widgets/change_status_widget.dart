import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/controller/reward_order_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_drop_down_widget.dart';

class ChangeStatusWidget extends StatelessWidget {
  ChangeStatusWidget({super.key});

  final controller = Get.put(RewardOrderController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! There Are title ..
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  title: "Reward Orders",
                  size: 16,
                  color: AppColors.blackBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(height: 10),
            CommonTextWidget(
                title: "Select Status Type:",
                size: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.blackBackgroundColor),
            const SizedBox(height: 10),
            CommonDropDownWidget(
                dropDownValue: controller.dropDownValue.value,
                valueList: controller.dropDownList),

            //! Here the Buttons ...

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonButtonWidget(
                      onPressed: () {},
                      buttonTxt: "Submit",
                      btnHeight: 40,
                      btnWidth: 100,
                      txtColor: AppColors.whiteBackgroundColor,
                      colors: AppColors.blueColor,
                      isEnabled: true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}