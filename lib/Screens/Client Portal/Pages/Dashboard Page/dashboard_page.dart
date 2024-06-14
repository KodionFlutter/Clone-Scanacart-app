import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientHome%20Page/controller/clienthome_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/label_validation_location_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/label_validation_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/serial_validation_verified_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/social_media_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_mail_listtile_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_icon_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class DashBoardPage extends StatelessWidget {
  DashBoardPage({super.key});

  final dashBoardController = Get.put(DashboardController());

  final clientHomeController = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CommonScrollBehaveWidget(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //! Product Logo ...!
            CustomContainerWidget(
                child: Obx(
              () => CachedNetworkImage(
                height: AppConstant.size.height * 0.25,
                width: AppConstant.size.width,
                imageUrl: dashBoardController.logo.value,
                fit: BoxFit.contain,
                placeholder: (context, url) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                errorWidget: (context, url, error) {
                  return Material(
                      color: Colors.transparent.withOpacity(0.8),
                      child: const Center(child: Text("Filed")));
                },
              ),
            )),
            //! Most Recent Emails ...!
            CustomContainerWidget(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget(
                        title: "Most Recent Emails",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                    InkWell(
                      onTap: () {
                        clientHomeController.selectedIndex.value = 2;
                        clientHomeController.titleName.value = "Client List";
                      },
                      child: const CustomIconWidget(
                          margin: 0,
                          padding: 8,
                          icon: Icons.mail,
                          iconSize: 18),
                    )
                  ],
                ),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),

                //! Show the List of recent mails...
                SizedBox(
                    height: 350,
                    width: double.maxFinite,
                    child: Obx(
                      () => dashBoardController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: dashBoardController.emailList.length,
                              itemBuilder: (context, index) {
                                return CommonMailListTileWidget(
                                  txtTitle:
                                      '${dashBoardController.recentEmailModel.recentEmailList![index].emailAddr}',
                                  txtSubTitle: Text(
                                    "${dashBoardController.recentEmailModel.recentEmailList![index].emailTimeDisplay}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  colors: Colors.red,
                                );
                              }),
                    )),
              ],
            )),
            //! Here Social Media Click Thru ...!
            SocialMediaWidget(
              onTap: () {
                clientHomeController.selectedIndex.value = 3;
                clientHomeController.titleName.value = "Maps";
              },
            ),
            //! Label Validations...!
            LabelValidationWidget(),
            //!   Serial Validation Verified.....!
            SerialValidationVerified(),
            //! Label Validation Location .....!
            LabelValidationLocationWidget()
          ],
        ),
      ),
    );
  }
}
