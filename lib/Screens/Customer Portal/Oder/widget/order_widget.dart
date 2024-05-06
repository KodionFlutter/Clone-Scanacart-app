import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/order_details.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderWidget extends StatelessWidget {
  final Color statusColor;
  final String title;
  final int orderId;
  final int totalPoints;
  final String oderDate;
  final VoidCallback onPressed;

  const OrderWidget(
      {super.key,
      required this.statusColor,
      required this.title,
      required this.orderId,
      required this.totalPoints,
      required this.oderDate,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        height: 80,
        width: AppConstant.size.width,
        decoration: BoxDecoration(
            gradient: AppColors.orderPage,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            //! Filled Color
            Container(
              width: 10,
              decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10))),
            ),
            const SizedBox(width: 10),
            //!
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Order Id: ${orderId.toString()}",
                  style: TextStyle(color: Colors.grey.shade700),
                )
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "POINTS: ${totalPoints.toString()}",
                ),
                SizedBox(height: 5),

                //! Here show the Date into ddd/mmm/yyyy
                Text("${oderDate.toString()}")
              ],
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
