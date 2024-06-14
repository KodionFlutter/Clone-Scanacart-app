import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Maps%20Page/controller/map_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

import '../../widgets/common_mail_listtile_widget.dart';

class MapsPage extends StatelessWidget {
  MapsPage({super.key});

  final mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CommonScrollBehaveWidget(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //! Top Countries ...
            CustomContainerWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    title: "Top Countries",
                    size: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                SizedBox(
                    height: 300,
                    child: Obx(
                      () => mapController.isCountries.value
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: mapController.topCountriesList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 35,
                                  child: CommonMailListTileWidget(
                                    txtTitle:
                                        '${mapController.topCountriesList[index].countryName}',
                                    trailing: Text(
                                        '${mapController.topCountriesList[index].cnt}'),
                                    colors: AppColors.orangeColor,
                                  ),
                                );
                              }),
                    ))
              ],
            )),

            //!
            CustomContainerWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    title: "Top US State",
                    size: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                SizedBox(
                    height: 300,
                    child: Obx(
                      () => mapController.isState.value
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: mapController.topStateList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 35,
                                  child: CommonMailListTileWidget(
                                    txtTitle:
                                        '${mapController.topStateList[index].stateName}',
                                    trailing: Text(
                                        "${mapController.topStateList[index].percentCnt}"),
                                    colors: AppColors.greenColor,
                                  ),
                                );
                              }),
                    ))
              ],
            )),

            //! Top Cities ..

            CustomContainerWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    title: "Top Cities",
                    size: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                SizedBox(
                    height: 300,
                    child: Obx(
                      () => mapController.isCities.value
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: mapController.topCitiesList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 35,
                                  child: CommonMailListTileWidget(
                                    txtTitle:
                                        '${mapController.topCitiesList[index].city}',
                                    trailing: Text(
                                        "${mapController.topCitiesList[index].cnt}"),
                                    colors: AppColors.blueColor,
                                  ),
                                );
                              }),
                    ))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
