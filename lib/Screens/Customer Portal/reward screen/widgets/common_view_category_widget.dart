import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CommonViewCategoryWidget extends StatelessWidget {
  final String categoryName;
  final int productRewardPoints;
  final String productTitle;
  final String productImage;
  final VoidCallback onTap;

  const CommonViewCategoryWidget(
      {super.key,
      required this.categoryName,
      required this.productRewardPoints,
      required this.productTitle,
      required this.productImage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                blurRadius: 2,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppConstant.size.width * 0.02),
                  topRight: Radius.circular(AppConstant.size.width * 0.02),
                ),
                child: CachedNetworkImage(
                  imageUrl: productImage,
                  // height: AppConstant.size.height * 0.16,
                  width: AppConstant.size.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Text('Could\'t load image',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black, fontSize: 10)),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: AppConstant.size.width * 0.01),
            Padding(
              padding: EdgeInsets.only(
                left: AppConstant.size.width * 0.03,
              ),
              child: Text(
                "${productTitle}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppConstant.size.width * 0.03, bottom: 5),
              child: Text("${productRewardPoints} Points"),
            ),
          ],
        ),
      ),
    );
  }
}
