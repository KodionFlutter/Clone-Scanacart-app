import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_icon_widget.dart';

class SocialMediaWidget extends StatelessWidget {
  final VoidCallback onTap;
  SocialMediaWidget({super.key, required this.onTap});

  final dashBoardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonTextWidget(
                title: "Social Media Click Thru",
                size: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor),
            InkWell(
              onTap: onTap,
              child: const CustomIconWidget(
                margin: 0,
                padding: 8,
                icon: Icons.share,
                iconSize: 18,
              ),
            )
          ],
        ),
        Divider(
            thickness: 1,
            color: AppColors.blackBackgroundColor.withOpacity(0.5)),
        Obx(() => ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (dashBoardController.socialList.isNotEmpty &&
                    dashBoardController.socialList[0]['instagram'] != 0)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.transparentColor,
                          child: const Image(
                            image: AssetImage("assets/images/instagram.png"),
                          ),
                        ),
                        title: const Text(
                          "Instagram",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${dashBoardController.socialList[0]['instagram']}",
                          style: TextStyle(color: AppColors.blueColor),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.greyBackgroundColor,
                      ),
                    ],
                  ),
                if (dashBoardController.socialList.isNotEmpty &&
                    dashBoardController.socialList[0]['snapchat'] != 0)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.transparentColor,
                          child: const Image(
                            image: AssetImage("assets/images/snapchat.png"),
                          ),
                        ),
                        title: const Text(
                          "Snapchat",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${dashBoardController.socialList[0]["snapchat"]}",
                          style: TextStyle(color: AppColors.blueColor),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.greyBackgroundColor,
                      ),
                    ],
                  ),
                if (dashBoardController.socialList.isNotEmpty &&
                    dashBoardController.socialList[0]['facebook'] != 0)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.transparentColor,
                          child: const Image(
                            image: AssetImage("assets/images/facebook.png"),
                          ),
                        ),
                        title: const Text(
                          "Facebook",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${dashBoardController.socialList[0]["facebook"]}",
                          style: TextStyle(color: AppColors.blueColor),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.greyBackgroundColor,
                      ),
                    ],
                  ),
                if (dashBoardController.socialList.isNotEmpty &&
                    dashBoardController.socialList[0]['twitter'] != 0)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.transparentColor,
                          child: const Image(
                            image: AssetImage("assets/images/twitter.png"),
                          ),
                        ),
                        title: const Text(
                          "Twitter",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${dashBoardController.socialList[0]["twitter"]}",
                          style: TextStyle(color: AppColors.blueColor),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.greyBackgroundColor,
                      ),
                    ],
                  ),
                if (dashBoardController.socialList.isNotEmpty &&
                    dashBoardController.socialList[0]['website'] != 0)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.transparentColor,
                          child: const Image(
                            image: AssetImage("assets/images/website.png"),
                          ),
                        ),
                        title: const Text(
                          "website",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${dashBoardController.socialList[0]["website"]}",
                          style: TextStyle(color: AppColors.blueColor),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.greyBackgroundColor,
                      ),
                    ],
                  ),
                const SizedBox(height: 25),
              ],
            )),
      ],
    ));
  }
}
