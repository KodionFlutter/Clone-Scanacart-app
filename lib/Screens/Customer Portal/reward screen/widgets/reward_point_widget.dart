import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/redeem_btn_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardPointWidget extends StatelessWidget {
  final String clinetName;
  final int rewardPoints;
  final int maxRange;
  final int minRange;

  const RewardPointWidget(
      {super.key,
      required this.clinetName,
      required this.rewardPoints,
      required this.maxRange,
      required this.minRange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
      child: Container(
        width: AppConstant.size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
                  padding: const EdgeInsets.all(1.0),
                  child: CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    child: Text("S",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              title: Text(clinetName.toString(),
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("$rewardPoints points",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
            // Progress Bar ..
          const  Padding(
              padding:  EdgeInsets.only(
                  left: 10, right: 10, top: 0, bottom: 0),
              child:  LinearProgressIndicator(
                value: 0.1,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${rewardPoints.toString()} Tier credits",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("${maxRange.toString()} to Platinum",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
           const SizedBox(height: 10),
            // Scan Cart
            Container(
              height: 27,
              width: 90,
              decoration: BoxDecoration(
                gradient: AppColors.verifyLinearGradientColor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10)),
              ),
              child: Center(
                  child: Text(
                "${clinetName}".toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
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
