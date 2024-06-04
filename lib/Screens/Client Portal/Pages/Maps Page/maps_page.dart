import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_icon_widget.dart';

import '../../widgets/common_mail_listtile_widget.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

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
                const Text("Top Countries"),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                SizedBox(
                    height: 300,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 35,
                            child: CommonMailListTileWidget(
                              txtTitle: 'United States',
                              trailing: const Text("10"),
                              colors: AppColors.orangeColor,
                            ),
                          );
                        }))
              ],
            )),

            //!
            CustomContainerWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Top US State"),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                SizedBox(
                    height: 300,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 35,
                            child: CommonMailListTileWidget(
                              txtTitle: 'Hawail',
                              trailing: const Text("0.5%"),
                              colors: AppColors.greenColor,
                            ),
                          );
                        }))
              ],
            )),

            //! Top Cities ..

            CustomContainerWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Top Cities"),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                SizedBox(
                    height: 300,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 35,
                            child: CommonMailListTileWidget(
                              txtTitle: 'Atlanta(GA)',
                              trailing: const Text("145"),
                              colors: AppColors.blueColor,
                            ),
                          );
                        }))
              ],
            )),
          ],
        ),
      ),
    );
  }
}