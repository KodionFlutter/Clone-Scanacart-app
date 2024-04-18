import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardCardWidget extends StatelessWidget {
  final String cartType;
  final String customerName;
  final String imagePath;

  const RewardCardWidget(
      {super.key,
      required this.cartType,
      required this.customerName,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstant.size.width * 0.02,
        vertical: AppConstant.size.height * 0.01,
      ),
      child: Container(
          height: AppConstant.size.height * 0.3,
          width: AppConstant.size.width,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(AppConstant.size.width * 0.05),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text("${customerName.toString()}".toUpperCase(),
                    style: TextStyle(
                      color: AppColors.txtWhiteColor,
                      fontSize: AppConstant.size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Positioned(
                  top: AppConstant.size.height * 0.03,
                  left: AppConstant.size.width * 0.03,
                  child: Text("${cartType.toString().toUpperCase()}",
                      style: TextStyle(
                        color: AppColors.txtWhiteColor,
                        fontSize: AppConstant.size.width*0.045,
                        fontWeight: FontWeight.bold,
                      ))),
              Positioned(
                  bottom: AppConstant.size.height*0.02,
                  right: AppConstant.size.width*0.03,
                  child: Text("Scanacart\n    Rewards".toUpperCase(),
                      style: TextStyle(
                        color: AppColors.txtWhiteColor,
                        fontSize: AppConstant.size.width*0.035,
                        fontWeight: FontWeight.bold,
                      ))),
              Positioned(
                bottom: AppConstant.size.height*0.02,
                left: AppConstant.size.width*0.03,
                child: SvgPicture.asset(
                  'assets/images/bag.svg',
                  semanticsLabel: 'My SVG Image',
                  height: AppConstant.size.height*0.08,
                  width: AppConstant.size.width*0.15,
                ),
              ),
            ],
          )),
    );
  }
}
