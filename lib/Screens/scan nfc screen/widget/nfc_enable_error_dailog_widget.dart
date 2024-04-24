import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class NotAvailableWidget extends StatelessWidget {
  final String message;
  String? title;

  NotAvailableWidget({
    super.key,
    required this.message,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cancel button
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(
                    left: 0,
                    right: AppConstant.size.width * 0.02,
                    top: AppConstant.size.width * 0.02),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.cancel_outlined,
                        size: AppConstant.size.height * 0.035)),
              ),
            ],
          ),
          //! Error image
          CircleAvatar(
            backgroundColor: AppColors.blackBackgroundColor.withOpacity(0.3),
            radius: AppConstant.size.height * 0.055,
            child: Image(
                image: AssetImage('assets/images/2error.png'),
                width: AppConstant.size.width * 0.8,
                height: AppConstant.size.height * 0.15),
          ),
          SizedBox(height: AppConstant.size.height * 0.02),

          title == null
              ? SizedBox()
              : Text(
                  "Serial #$title".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins'),
                ),

          Material(
              color: Colors.transparent,
              child: Padding(
                  padding: EdgeInsets.only(
                    left: AppConstant.size.width * 0.03,
                    right: AppConstant.size.width * 0.03,
                    bottom: AppConstant.size.height * 0.01,
                  ),
                  child: Html(
                    data: message,
                    style: {
                      "*": Style(
                        textAlign: TextAlign.center,
                        alignment: Alignment.center,
                        fontSize: FontSize(17, Unit.px),
                        color: AppColors.txtErrorTxtColor,
                        display: Display.block,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      ),
                      "b": Style(
                        textAlign: TextAlign.center,
                        alignment: Alignment.center,
                        color: AppColors.txtErrorTxtColor,
                        fontSize: FontSize(25, Unit.px),
                        display: Display.block,
                        fontWeight: FontWeight.bold,
                      ),
                    },
                  )))
        ],
      ),
    );
  }
}
