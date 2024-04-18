import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/redeem_btn_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardPointWidget extends StatelessWidget {
  final String clientName;
  final int rewardPoints;
  final int maxRange;
  final int minRange;
  final VoidCallback onPressed;

  const RewardPointWidget(
      {super.key,
      required this.clientName,
      required this.rewardPoints,
      required this.maxRange,
      required this.minRange, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppConstant.size.width * 0.03,
        right: AppConstant.size.width * 0.03,
        top: AppConstant.size.height * 0.02,
        bottom: 0,
      ),
      child: Container(
        width: AppConstant.size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstant.size.width * 0.03),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 2, offset: Offset(2, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!
            ListTile(
              isThreeLine: false,
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Padding(
                  padding: EdgeInsets.all(AppConstant.size.width * 0.002),
                  child: CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    child: Text("S",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: AppConstant.size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              title: Text(clientName.toString(),
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: AppConstant.size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("$rewardPoints points",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: AppConstant.size.width * 0.03,
                    fontWeight: FontWeight.w600,
                  )),
              trailing: RedeemBtnWidget(
                onPressed: onPressed,
                buttonTxt: 'Redeem',
                btnHeight: AppConstant.size.height * 0.045,
                btnWidth: AppConstant.size.width * 0.30,
                txtColor: Colors.white,
                linearGradient: AppColors.verifyLinearGradientColor,
              ),
            ),
            // Progress Bar ..
            Padding(
              padding: EdgeInsets.only(
                left: AppConstant.size.width * 0.02,
                right: AppConstant.size.width * 0.02,
                top: 0,
                bottom: 0,
              ),
              child: LinearProgressIndicator(
                value: 0.1,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                color: Colors.grey,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
                left: AppConstant.size.width * 0.02,
                right: AppConstant.size.width * 0.02,
                top: AppConstant.size.height*0.01,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${rewardPoints.toString()} Tier credits",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: AppConstant.size.width*0.035,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("${maxRange.toString()} to Platinum",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize:  AppConstant.size.width*0.035,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
             SizedBox(height:  AppConstant.size.height*0.01),
            // Scan Cart
            Container(
              height:  AppConstant.size.height*0.035,
              width:  AppConstant.size.width*0.3,
              decoration: BoxDecoration(
                gradient: AppColors.verifyLinearGradientColor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(AppConstant.size.width*0.02)),
              ),
              child: Center(
                  child: Text(
                "${clientName}".toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:  AppConstant.size.width*0.035,
                  fontWeight: FontWeight.bold,
                  color: AppColors.txtWhiteColor,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
