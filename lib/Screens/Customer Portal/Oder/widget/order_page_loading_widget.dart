import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/widgets/shimmer_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderPageLoadingPageWidget extends StatelessWidget {
  const OrderPageLoadingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ShimmerWidget(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 0),
              height: 80,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
          );
        });
  }
}
