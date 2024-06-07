import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/Products%20Page/controller/reward_product_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/Products%20Page/widgets/product_list_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_search_bar_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_details_page.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({super.key});

  final rewardProductController = Get.put(RewardProductController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CommonScrollBehaveWidget(),
      child: Column(
        children: [
          //!Search Bar
          CustomSearchBarWidget(
              onChanged: () {},
              controller: rewardProductController.searchController.value),

          //! Product List here .
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        //! Navigate them into Details Page..
                        Get.to(CategoryDetailsPage(
                          productId: 1910,
                          clientId: 205,
                          clientName: '',
                          isBool: false,
                        ));
                      },
                      child: const RewardProductListWidget());
                }),
          )
        ],
      ),
    );
  }
}