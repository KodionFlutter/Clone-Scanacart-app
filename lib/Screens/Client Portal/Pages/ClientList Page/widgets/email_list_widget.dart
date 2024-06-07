import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientList%20Page/recupients_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

class EmailListWidget extends StatelessWidget {
  const EmailListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Yes clicked");
        Get.to(RecipientPage());
      },
      child: CustomContainerWidget(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextWidget(
                      title: "Select Email Address",
                      size: 14,
                      color: AppColors.blackBackgroundColor),
                ),
              ],
            ),
          ),

          //! Show here the Email List..

          Wrap(
            runSpacing: 1,
            spacing: 5,
            direction: Axis.horizontal,
            children: [
              Chip(
                backgroundColor: AppColors.blackBackgroundColor,
                deleteButtonTooltipMessage: "Remove the email",
                deleteIconColor: Colors.white,
                onDeleted: () {},
                label: CommonTextWidget(
                    title: "s@gmail.com",
                    size: 14,
                    color: AppColors.whiteBackgroundColor),
              ),
              Chip(
                backgroundColor: AppColors.blackBackgroundColor,
                deleteButtonTooltipMessage: "Remove the email",
                deleteIconColor: Colors.white,
                onDeleted: () {},
                label: CommonTextWidget(
                    title: "s@gmail.com",
                    size: 14,
                    color: AppColors.whiteBackgroundColor),
              ),
              Chip(
                backgroundColor: AppColors.blackBackgroundColor,
                deleteButtonTooltipMessage: "Remove the email",
                deleteIconColor: Colors.white,
                onDeleted: () {},
                label: CommonTextWidget(
                    title: "s@gmail.com",
                    size: 14,
                    color: AppColors.whiteBackgroundColor),
              ),
            ],
          ),
        ],
      )),
    );
  }
}