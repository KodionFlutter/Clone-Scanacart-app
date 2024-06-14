import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_icon_widget.dart';

class AccountSettingWidget extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;

  const AccountSettingWidget(
      {super.key,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomIconWidget(
        margin: 0.0,
        padding: 8.0,
        icon: leadingIcon,
        iconSize: 15,
      ),
      title: CommonTextWidget(
        title: title,
        size: 14,
        color: AppColors.blackColor,
      ),
      trailing: Icon(
        trailingIcon,
        size: 15,
        color: AppColors.blackColor,
      ),
    );
  }
}