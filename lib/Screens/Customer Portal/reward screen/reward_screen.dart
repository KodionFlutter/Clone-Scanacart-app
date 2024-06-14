import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Common/widgets/common_web_view.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/reward_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/client_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/loading_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/reward_card_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/reward_point_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardScreen extends StatelessWidget {
  final int customerId;

  RewardScreen({super.key, required this.customerId});

  final rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    rewardController.getAlleMethod();
    return Obx(() {
      if (rewardController.data.values.isEmpty) {
        return const LoadingWidget();
      } else {
        return ScrollConfiguration(
          behavior: CommonScrollBehaveWidget(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ! Calling Reward card widget
                Obx(
                  () => RewardCardWidget(
                    cartType: rewardController.cardName.value,
                    customerName: rewardController.customerName.value,
                    imagePath: rewardController.cardPath.value,
                    svgImage: rewardController.cardName.value,
                  ),
                ),
                //! Start

                Column(
                  children: [
                    // First, display widgets for rewards with card_detail
                    for (var reward in rewardController.data['rewards'])
                      if (reward.containsKey('card_detail'))
                        _buildRewardWidget(reward),
                    // Then, display widgets for rewards without card_detail
                    for (var reward in rewardController.data['rewards'])
                      if (!reward.containsKey('card_detail'))
                        _buildRewardWidget(reward),
                  ],
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
                        boxShadow: const [
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
                                  "Our amazing rewards platform allows our customers enjoy reward points from their favorite brands while also earning Scanacart reward points!",
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
                                      title: rewardController.clientName2.value
                                          .toString(),
                                      url: rewardController.clientLogo2.value,
                                    ));
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  Widget _buildRewardWidget(Map<String, dynamic> reward) {
    String clientName = reward['client_name'];
    dynamic cardDetail = reward['card_detail'];

    if (cardDetail != null && cardDetail.isNotEmpty) {
      return RewardPointWidget(
        clientName: clientName,
        rewardPoints: reward['reward_points'],
        maxRange: cardDetail[0]['max_range'],
        minRange: cardDetail[0]['min_range'],
        onPressed: () {
          Get.to(CategoryPage(
            clientId: reward['client_id'],
            clientName: clientName,
          ))!
              .then((value) => rewardController.getAlleMethod());
        },
      );
    } else {
      return ClientWidget(
        imageUrl: reward['client_logo'],
        rewardPoints: reward['reward_points'],
        clientName: clientName,
        onPressed: () {
          Get.to(CategoryPage(
            clientId: reward['client_id'],
            clientName: clientName,
          ))!
              .then((value) => rewardController.getAlleMethod());
        },
      );
    }
  }
}
