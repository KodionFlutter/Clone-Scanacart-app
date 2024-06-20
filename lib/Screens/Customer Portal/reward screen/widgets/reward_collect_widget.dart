import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardCollectWidget extends StatelessWidget {
  final VoidCallback onTap, onPressed;
  final String rewardPoints;

  const RewardCollectWidget(
      {super.key,
      required this.onTap,
      required this.onPressed,
      required this.rewardPoints});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AlertDialog(
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstant.size.width * 0.04),
          ),
          content: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: AppConstant.size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 40.0,
                      child: Icon(
                        Icons.star,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Congratulations !',
                      style: TextStyle(
                        fontSize: AppConstant.size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'You have unlocked ${rewardPoints.toString()} rewards!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 40.0),
                    CommonButtonWidget(
                      isEnabled: true,
                      onPressed: onPressed,
                      buttonTxt: 'Redeem',
                      btnHeight: AppConstant.size.height * 0.05,
                      btnWidth: AppConstant.size.width * 0.5,
                      txtColor: AppColors.whiteBackgroundColor,
                      colors: Colors.blue,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -70.0,
                child: Image.asset(
                  'assets/gif/reward2.gif',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -30,
                right: -40,
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    width: AppConstant.size.width * 0.15,
                    height: AppConstant.size.height * 0.05,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
