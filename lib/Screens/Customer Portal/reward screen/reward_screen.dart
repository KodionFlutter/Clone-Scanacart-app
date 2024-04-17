import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/reward_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/client_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/custome_floating_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/logout_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/reward_card_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/reward_point_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardScreen extends StatelessWidget {
  final int customerId;

  const RewardScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.put(RewardController(id: customerId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBackgroundColor,
        elevation: 0,
        title: Center(child: Text("Rewards")),
        actions: [
          LogoutWidget(),
        ],
      ),
      body: Obx(() {
        if (rewardController.rewardata.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, index) {
                return Column(
                  children: [
                    //! Calling Reward card widget
                    Obx(
                      () => RewardCardWidget(
                        cartType: rewardController
                            .rewardata[1].cardDetail![0].cardName
                            .toString(),
                        customerName: "shaim",
                        imagePath: rewardController.cardPath.value,
                      ),
                    ),
                    // Calling reward point widget
                    RewardPointWidget(
                      clientName:
                          rewardController.rewardata[1].clientName.toString(),
                      rewardPoints: rewardController.rewardata[1].rewardPoints!,
                      maxRange: rewardController
                          .rewardata[1].cardDetail![0].maxRange!,
                      minRange: rewardController
                          .rewardata[1].cardDetail![0].minRange!,
                    ),
                    //! calling  here client widget
                    ClientWidget(
                      imageUrl:
                          rewardController.rewardata[0].clientLogo.toString(),
                      rewardPoints: rewardController.rewardata[0].rewardPoints!,
                      clientName:
                          rewardController.rewardata[0].clientName.toString(),
                    ),
                    //! WebView Link ..
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppConstant.size.width * 0.03,
                          right: AppConstant.size.width * 0.03),
                      child: Container(
                        width: AppConstant.size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.size.width * 0.03),
                            color: AppColors.whiteBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  offset: Offset(2, 2))
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: AppConstant.size.width * 0.03,
                              right: AppConstant.size.width * 0.01,
                              top: AppConstant.size.height * 0.015,
                              bottom: AppConstant.size.height * 0.015),
                          child: RichText(
                            text: TextSpan(
                              text: "What is Scanacart Rewards?\n",
                              style: TextStyle(
                                fontSize: AppConstant.size.width * 0.04,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "Our amazing rewads platform allows our customers enjoy reward points from their favorite brands while also earning Scanacart reward points!",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: AppConstant.size.width * 0.035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                    text: "\nMore Info",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: AppConstant.size.width * 0.035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
      })

      // Floating Animated Button ..

      ,
      // floatingActionButton: Obx(
      //   () => Stack(
      //     clipBehavior: Clip.none,
      //     children: [
      //       Positioned(
      //         bottom: 0,
      //         right: 0,
      //         child: AnimatedBuilder(
      //           animation: rewardController.rotateAnimation,
      //           builder: (context, child) {
      //             return Transform.rotate(
      //               angle: rewardController.rotateAnimation.value,
      //               child: child,
      //             );
      //           },
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.end,
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               if (rewardController.isExpanded.value)
      //                 _buildMenuButton(0, Icons.add),
      //               if (rewardController.isExpanded.value)
      //                 _buildMenuButton(1, Icons.edit),
      //               if (rewardController.isExpanded.value)
      //                 _buildMenuButton(2, Icons.delete),
      //             ],
      //           ),
      //         ),
      //       ),
      //       FloatingActionButton(
      //         onPressed: rewardController.toggleExpand,
      //         child: AnimatedIcon(
      //           icon: AnimatedIcons.menu_close,
      //           progress: rewardController.animationController,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: CustomeFloatingButtonWidget(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}