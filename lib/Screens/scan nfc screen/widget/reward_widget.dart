import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardWidget extends StatelessWidget {
  final VoidCallback onTap;
 const  RewardWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        decoration:const  BoxDecoration(shape: BoxShape.circle),
        child: SvgPicture.asset(
          'assets/images/reward.svg',
          width: 26,
          height: 26,
        ),
      ),
    );
  }
}
