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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
          height: AppConstant.size.height * 0.22,
          width: AppConstant.size.width,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20),
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
                      fontSize: 25,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: Text("${cartType.toString().toUpperCase()}",
                      style: TextStyle(
                        color: AppColors.txtWhiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))),
              Positioned(
                  bottom: 20,
                  right: 20,
                  child: Text("Scanacart\n    Rewards".toUpperCase(),
                      style: TextStyle(
                        color: AppColors.txtWhiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))),
              Positioned(
                bottom: 20,
                left: 20,
                child: SvgPicture.asset(
                  'assets/images/bag.svg',
                  semanticsLabel: 'My SVG Image',
                  height: 60,
                  width: 60,
                ),
              ),
            ],
          )),
    );
  }
}
