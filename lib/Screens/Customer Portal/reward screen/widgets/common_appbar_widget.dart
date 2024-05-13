import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/cart_counter_widget.dart';


class CommonAppbar extends StatelessWidget {
  final String title;
  final Widget body;
  Widget? bottomNavigationBar;
  final int clientId;
  final String clientName;
  final VoidCallback onTap;

  CommonAppbar(
      {super.key,
      required this.title,
      required this.body,
      this.bottomNavigationBar,
      required this.clientId,
      required this.clientName,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
        title: Center(
            child: Text(
          title,
        )),
        actions: [
          CartCounterWidget(
            clientId: clientId,
            clientName: clientName,
            onTap: onTap,
          )
        ],
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
