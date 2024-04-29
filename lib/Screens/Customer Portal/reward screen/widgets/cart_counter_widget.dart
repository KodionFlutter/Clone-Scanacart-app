import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/cart_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/cart_controller.dart';

class CartCounterWidget extends StatelessWidget {
  final int clientId;
  final String clientName;

  CartCounterWidget({
    Key? key,
    required this.clientId,
    required this.clientName,
  }) : super(key: key);

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 18, top: 10),
      child: SizedBox(
        height: 150.0,
        width: 30.0,
        child: GestureDetector(
          onTap: () {
            Get.to(CartPage(
              clientId: clientId,
              clientName: clientName,
            ));
          },
          child: Obx(
            () => Stack(
              clipBehavior: Clip.none,
              children: [
                const IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: null,
                ),
                Positioned(
                  top: cartController.totalQuantity > 998 ? -9 : -2,
                  right: -14,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: cartController.totalQuantity > 998 ? 14 : 10,
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text(
                            cartController.totalQuantity == 0
                                ? "0"
                                : cartController.totalQuantity.toString(),
                            style: TextStyle(
                              color: AppColors.whiteBackgroundColor,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
