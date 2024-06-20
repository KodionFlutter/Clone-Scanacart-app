import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class ProductStatusWidget extends StatelessWidget {
  final String statusName;
  final IconData iconData;
  final Color backGroundColor, statusColor;
  final double width;

  const ProductStatusWidget({
    super.key,
    required this.statusName,
    required this.iconData,
    required this.backGroundColor,
    required this.statusColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: backGroundColor,
              child: Icon(
                iconData,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 3,
              width: width,
              color: statusColor,
            ),
            const SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          statusName,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}