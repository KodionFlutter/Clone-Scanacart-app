import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/reward_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/client_widget.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.power_settings_new_outlined),
          )
        ],
      ),
      body: ListView.builder(
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
                  clinetName:
                      rewardController.rewardata[1].clientName.toString(),
                  rewardPoints: rewardController.rewardata[1].rewardPoints!,
                  maxRange:
                      rewardController.rewardata[1].cardDetail![0].maxRange!,
                  minRange:
                      rewardController.rewardata[1].cardDetail![0].minRange!,
                ),
                //! calling  here client widget
                ClientWidget(
                  imageUrl: rewardController.rewardata[0].clientLogo.toString(),
                  rewardPoints: rewardController.rewardata[0].rewardPoints!,
                  clientName:
                      rewardController.rewardata[0].clientName.toString(),
                ),
                //! WebView Link ..
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: AppConstant.size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(2, 2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 5, top: 10, bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          text: "What is Scanacart Rewards?\n",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "Our amazing rewads platform allows our customers enjoy reward points from their favorite brands while also earning Scanacart reward points!",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                                text: "\nMore Info",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
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
          }),

      // Floating Animated Button ..

      floatingActionButton: Obx(
        () => Stack(
          clipBehavior: Clip.none,
          children: [
            rewardController.isExpanded.value
                ? Positioned(
                    bottom: 90,
                    right: 0,
                    child: Transform.rotate(
                      angle: rewardController.rotateAnimation.value,
                      child: FloatingActionButton(
                        onPressed: () {},
                        tooltip: 'Button 1',
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                : SizedBox(),
            rewardController.isExpanded.value
                ? Positioned(
                    bottom: 0,
                    right: 90,
                    child: Transform.rotate(
                      angle: rewardController.rotateAnimation.value,
                      child: FloatingActionButton(
                        onPressed: () {},
                        tooltip: 'Button 1',
                        child: Icon(Icons.home),
                      ),
                    ),
                  )
                : SizedBox(),
            rewardController.isExpanded.value
                ? Positioned(
                    bottom: 0,
                    left: 90,
                    child: Transform.rotate(
                      angle: rewardController.rotateAnimation.value,
                      child: FloatingActionButton(
                        onPressed: () {},
                        tooltip: 'Button 1',
                        child: Icon(Icons.edit),
                      ),
                    ),
                  )
                : SizedBox(),
            FloatingActionButton(
              onPressed: rewardController.toggleExpand,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: rewardController.animationController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
