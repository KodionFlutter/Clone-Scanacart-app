import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_widget.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/scan_nfc_screen.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Orders"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => const [
                PopupMenuItem(value: 1, child: Text("All")),
                PopupMenuItem(value: 1, child: Text("Pending")),
                PopupMenuItem(value: 1, child: Text("Cancle")),
                PopupMenuItem(value: 2, child: Text("Fulfilled")),
              ],
              offset: Offset(10, 10),
              shadowColor: Colors.black,
              color: AppColors.whiteBackgroundColor,
              elevation: 2,
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return OrderWidget();
            }));
  }
}
