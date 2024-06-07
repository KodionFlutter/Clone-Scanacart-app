import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/controller/clinet_order_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/orders_product_list.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_search_bar_widget.dart';

class ClientOrdersPage extends StatelessWidget {
  ClientOrdersPage({super.key});

  final clientOrderController = Get.put(ClientOrdersController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Here are search bar

        CustomSearchBarWidget(
          onChanged: () {},
          controller: clientOrderController.searchController.value,
        ),

        //! Here are the List ..

        Expanded(
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return OrdersProductList(
                  addCommentController:
                      clientOrderController.addCommentController.value,
                );
              }),
        ),
      ],
    );
  }
}