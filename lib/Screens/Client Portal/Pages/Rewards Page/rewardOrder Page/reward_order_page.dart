import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/controller/reward_order_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/widgets/flitter_dialogbox_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/widgets/reward_order_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_search_bar_widget.dart';

class RewardOrderPage extends StatelessWidget {
  RewardOrderPage({super.key});

  final rewardOrderController = Get.put(RewardOrderController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Search Bar and Filters...

        Row(
          children: [
            Expanded(
              child: CustomSearchBarWidget(
                  onChanged: () {},
                  controller: rewardOrderController.searchController.value),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return FlitterDialogBoxWidget();
                    });
              },
              icon: const Icon(
                Icons.filter_list_alt,
              ),
            ),
            PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text("Export Order"),
                      ),
                    ]),
          ],
        ),
        //! Order List ..
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const RewardOrderWidget();
              }),
        )
      ],
    );
  }
}