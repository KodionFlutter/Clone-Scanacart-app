import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CommonPageViewWidget extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;
  final String categoryImage;
  final VoidCallback onPressed;

  const CommonPageViewWidget(
      {super.key,
      required this.categoryName,
      required this.categoryDescription,
      required this.categoryImage,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstant.size.height * 1,
      width: AppConstant.size.width,
      child: Stack(
        // fit: StackFit.loose,
        children: [
          SizedBox.expand(
            child: CachedNetworkImage(
              imageUrl: categoryImage,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Text("S");
              },
              errorWidget: (context, url, error) {
                return Material(
                  color: Colors.transparent.withOpacity(0.8),
                  child: const Center(
                    child: Text('Could\'t load image',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                  ),
                );
              },
            ),
          ),
          Container(
            height: AppConstant.size.height,
            width: AppConstant.size.width,
            decoration: BoxDecoration(
              color: Colors.black38
            ),
          ),
          Positioned(
            top: AppConstant.size.height * 0.03,
            left: AppConstant.size.width * 0.05,
            child: Text(
              "${categoryName}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppConstant.size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: AppColors.txtWhiteColor,
              ),
            ),
          ),
          Positioned(
            top: AppConstant.size.height * 0.08,
            left: AppConstant.size.width * 0.05,
            child: SizedBox(
              width: AppConstant.size.width*0.9,
              child: Text(
                "${categoryDescription}",
                softWrap: true,
                // maxLines: 5,
                // overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: AppConstant.size.width * 0.05,
                  fontWeight: FontWeight.w400,
                  color: AppColors.txtWhiteColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: AppConstant.size.height * 0.03),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CommonButtonWidget(
                onPressed: onPressed,
                buttonTxt: 'View Product',
                btnHeight: AppConstant.size.height * 0.08,
                btnWidth: AppConstant.size.width * 0.6,
                txtColor: Colors.black,
                colors: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
