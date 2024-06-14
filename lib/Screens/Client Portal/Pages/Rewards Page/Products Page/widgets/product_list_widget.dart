import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/Products%20Page/widgets/edit_reward_product.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

class RewardProductListWidget extends StatelessWidget {
  const RewardProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return CustomContainerWidget(
    //     padding: 0.0,
    //     child: Stack(
    //       clipBehavior: Clip.hardEdge,
    //       children: [
    //         Container(
    //           height: 200,
    //           width: 300,
    //         ),
    //         Positioned(
    //           top: -5,
    //           left: -30,
    //           child: Transform.rotate(
    //             angle: -0.785398, // 45 degrees in radians
    //             child: Container(
    //               color: Colors.blue,
    //               width: 130,
    //               height: 30,
    //               child: Text(
    //                 'Active',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ));
    return CustomContainerWidget(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CommonTextWidget(
                title: "Gift cart 1",
                size: 15,
                color: AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        CommonTextWidget(
          title: "ProductId : 203",
          size: 15,
          color: AppColors.blackBackgroundColor,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 5),
        CommonTextWidget(
          title: "Product Quantity : 11",
          size: 15,
          color: AppColors.blackBackgroundColor,
          fontWeight: FontWeight.w400,
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparentColor,
                  elevation: 0,
                  side: BorderSide(color: Colors.black, width: 1)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditRewardProduct();
                    });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text("Edit")
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}