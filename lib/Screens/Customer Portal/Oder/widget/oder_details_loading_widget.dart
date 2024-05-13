import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/shimmer_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderDetailsLoadingWidget extends StatelessWidget {
  const OrderDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          //!
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            width: AppConstant.size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: AppColors.orderPage,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Order Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 130,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                        height: 10, width: 100, color: AppColors.blueColor),
                  ],
                ),
                const SizedBox(height: 8),
                //! date of booking order .
                Container(
                  height: 10,
                  width: 130,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: 120,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: 110,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 10,
                  width: 90,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 10,
                  width: 90,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 10,
                        width: 100,
                        color: AppColors.blueColor,
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 100,
                      color: AppColors.blueColor,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          //!
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            width: AppConstant.size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: AppColors.orderPage,
            ),
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
              ),
              title: Container(
                height: 10,
                width: 90,
                decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
              subtitle: Container(
                height: 10,
                width: 90,
                decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
              trailing: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),

          //!
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            width: AppConstant.size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: AppColors.orderPage,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Order Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                //! date of booking order .
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 0,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
