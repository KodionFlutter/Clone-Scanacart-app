import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class CommonMailListTileWidget extends StatelessWidget {
  final String txtTitle;
  var txtSubTitle;
  final Color colors;
  var trailing;

  CommonMailListTileWidget(
      {super.key,
      this.trailing,
      required this.txtTitle,
      this.txtSubTitle,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: true,
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          CircleAvatar(
            radius: 9,
            backgroundColor: colors,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: CircleAvatar(
                backgroundColor: AppColors.txtWhiteColor,
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: colors,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      title: Text(txtTitle.toString(),
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      subtitle: txtSubTitle,
      trailing: trailing,
    );
  }
}