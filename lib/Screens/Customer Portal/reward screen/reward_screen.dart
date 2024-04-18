import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_web_view.dart';
import 'package:scan_cart_clone/Common/widgets/shimmer_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/reward_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/client_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/custome_floating_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/logout_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/reward_card_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/reward_point_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shimmer/shimmer.dart';

class RewardScreen extends StatelessWidget {
  final int customerId;

  const RewardScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.put(RewardController(id: customerId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(child: Text("Rewards")),
        actions: [
          LogoutWidget(),
        ],
      ),
      body: Obx(() {
        if (rewardController.rewardata.isEmpty) {
          return Column(
            children: [
              ShimmerWidget(
                height: AppConstant.size.height * 0.3,
                width: AppConstant.size.width,
              ),
              ShimmerWidget(
                height: AppConstant.size.height * 0.2,
                width: AppConstant.size.width,
              ),
              ShimmerWidget(
                height: AppConstant.size.height * 0.1,
                width: AppConstant.size.width,
              ),
              ShimmerWidget(
                height: AppConstant.size.height * 0.1,
                width: AppConstant.size.width,
              ),
            ],
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
                      onPressed: () {
                        Get.to(CategoryPage(
                          clientId: rewardController.rewardata[1].clientId!,
                          clientName: rewardController.rewardata[1].clientName
                              .toString(),
                        ));
                      },
                    ),
                    //! calling  here client widget
                    ClientWidget(
                      imageUrl:
                          rewardController.rewardata[0].clientLogo.toString(),
                      rewardPoints: rewardController.rewardata[0].rewardPoints!,
                      clientName:
                          rewardController.rewardata[0].clientName.toString(),
                      onPressed: () {
                        Get.to(CategoryPage(
                          clientId: rewardController.rewardata[0].clientId!,
                          clientName: rewardController.rewardata[0].clientName
                              .toString(),
                        ));
                      },
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
                                      ..onTap = () {
                                        Get.to(CommonWebView(
                                          title: rewardController
                                              .rewardata[1].clientName
                                              .toString(),
                                          url: rewardController
                                              .rewardata[1].clientLogo!,
                                        ));
                                      }),
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
      }),

      // Floating Animated Button ..
      floatingActionButton: CustomeFloatingButtonWidget(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
