import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/reward_order_details_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

class RewardOrderWidget extends StatelessWidget {
  const RewardOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
        margin: 10.0,
        padding: 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 5,
              height: 106,
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(
                          title: 'Ed',
                          size: 14,
                          color: AppColors.blackBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CommonTextWidget(
                          title: 'Points : 46',
                          size: 14,
                          color: AppColors.blackBackgroundColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(
                          title: 'Order Id : 146',
                          size: 14,
                          color: AppColors.blackBackgroundColor,
                          fontWeight: FontWeight.w400,
                        ),
                        CommonTextWidget(
                          title: '18 Apr 2024',
                          size: 14,
                          color: AppColors.blackBackgroundColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(RewardOrderDetailsPage());
                          },
                          child: const Text(
                            "View details",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}