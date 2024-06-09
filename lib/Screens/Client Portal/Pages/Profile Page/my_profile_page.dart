import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Profile%20Page/widgets/account_setting_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!
          CustomContainerWidget(
              child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    title: "Account Setting",
                    size: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor),
                SizedBox(height: 5),
                Divider(
                  thickness: 1,
                  color: AppColors.greyBackgroundColor,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const  AccountSettingWidget(
                        leadingIcon: Icons.settings,
                        trailingIcon: Icons.arrow_forward_ios_outlined,
                        title: 'Account Information',
                      );
                    }),
              ],
            ),
          ))
        ],
      ),
    );
  }
}