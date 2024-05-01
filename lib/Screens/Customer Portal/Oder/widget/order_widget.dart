import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/order_details.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(OrderDetails());
      },
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
              decoration: const BoxDecoration(
                  color: Colors.yellow,
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
                const Text(
                  "Packman",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Order Id: 153",
                  style: TextStyle(color: Colors.grey.shade700),
                )
              ],
            ),
            const Spacer(),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "POINTS: 53",
                ),
                SizedBox(height: 5),
                Text("24 Apr 2024")
              ],
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
