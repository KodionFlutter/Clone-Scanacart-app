import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/redeem_btn_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class ClientWidget extends StatelessWidget {
  final String imageUrl;
  final int rewardPoints;
  final String clientName;

  const ClientWidget(
      {super.key,
      required this.imageUrl,
      required this.rewardPoints,
      required this.clientName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: AppConstant.size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 2, offset: Offset(2, 2))
            ]),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(1.0),
            child: CircleAvatar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
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
          ),
          title: Text(
            "$clientName",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: AppColors.blackColor,
            ),
          ),
          subtitle: Text("$rewardPoints points",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
                color: AppColors.blackColor,
              )),
          trailing: RedeemBtnWidget(
            onPressed: () {},
            buttonTxt: 'Redeem',
            btnHeight: 35,
            btnWidth: 120,
            txtColor: Colors.white,
            linearGradient: AppColors.verifyLinearGradientColor,
          ),
        ),
      ),
    );
  }
}
