import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_address_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_item_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_totalpoints_widget.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Order Detail"),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          //!
          OrderDetailsAddressWidget(),
          OrderDetailsItemWidget(),
          OrderDetailsTotalPointsWidget(),
        ],
      ),
    );
  }
}
