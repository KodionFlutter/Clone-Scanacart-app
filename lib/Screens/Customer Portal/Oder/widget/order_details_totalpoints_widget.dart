import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderDetailsTotalPointsWidget extends StatelessWidget {
  final int pointsAmount;
  final int cachingCon;
  final int discount;
  final int totalAmount;
  final Widget button;

  const OrderDetailsTotalPointsWidget(
      {super.key,
      required this.pointsAmount,
      required this.cachingCon,
      required this.discount,
      required this.totalAmount,
      required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      width: AppConstant.size.width * 1,
      // height: AppConstant.size.height*1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppColors.orderPage,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Order Details
          Text("Total Points".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          //! Points amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Points Amount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Text(
                "$pointsAmount",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //! Caching Conversion
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Caching Conversion",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Text(
                "$cachingCon",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //! Discount..
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Discount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Text(
                "$discount",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //! Divider ..
          const Divider(thickness: 1, color: Colors.black54),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Total Amout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Text(
                "$totalAmount",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 1, color: Colors.black54),
          const SizedBox(height: 10),
          Container(child: button)
        ],
      ),
    );
  }
}
