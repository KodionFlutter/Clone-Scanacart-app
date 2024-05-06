import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderDetailsDialogBoxWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;

  const OrderDetailsDialogBoxWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.textEditingController,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(15),
        width: AppConstant.size.width,
        decoration: BoxDecoration(
            color: AppColors.txtWhiteColor,
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$title".toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Text("$subTitle",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 15),
            //! Make A TextEditController for write the comment/feedback..
            TextFormField(
              maxLines: 5,
              controller: textEditingController,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
              )),
            ),

            SizedBox(height: 15),
            //! Make here a button ..
            Center(
              child: CommonButtonWidget(
                onPressed: onPressed,
                buttonTxt: 'Submit',
                btnHeight: AppConstant.size.height * 0.06,
                btnWidth: AppConstant.size.width * 0.5,
                txtColor: AppColors.txtWhiteColor,
                colors: Colors.lightBlue,
                isEnabled: true,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
