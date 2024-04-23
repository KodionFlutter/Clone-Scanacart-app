import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/redeem_btn_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class ClientWidget extends StatelessWidget {
  final String imageUrl;
  final int rewardPoints;
  final String clientName;
  final VoidCallback onPressed;

  const ClientWidget(
      {super.key,
      required this.imageUrl,
      required this.rewardPoints,
      required this.clientName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstant.size.width * 0.03,
          right: AppConstant.size.width * 0.03,
          top: AppConstant.size.height * 0.01,
          bottom: AppConstant.size.height * 0.005),
      child: Container(
        width: AppConstant.size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstant.size.width * 0.03),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 2, offset: Offset(2, 2))
            ]),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(AppConstant.size.width * 0.01),
            child: CircleAvatar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
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
          ),
          title: Text(
            "$clientName",
            style: TextStyle(
              fontSize: AppConstant.size.width * 0.035,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          subtitle: Text("$rewardPoints points",
              style: TextStyle(
                fontSize: AppConstant.size.width * 0.03,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: AppColors.blackColor,
              )),
          trailing: RedeemBtnWidget(
            onPressed: onPressed,
            buttonTxt: 'Redeem',
            btnHeight: AppConstant.size.height * 0.045,
            btnWidth: AppConstant.size.width * 0.3,
            txtColor: Colors.white,
            linearGradient: AppColors.verifyLinearGradientColor,
          ),
        ),
      ),
    );
  }
}
