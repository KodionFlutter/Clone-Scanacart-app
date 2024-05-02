import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer Portal/reward screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Screens/Customer Portal/reward screen/widgets/cart_product_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/shipping_address_page.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CartPage extends StatelessWidget {
  final int clientId;
  final String clientName;

  const CartPage({Key? key, required this.clientId, required this.clientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          cartController.totalQuantity;
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
                SizedBox(height: 20),
                Text(
                  "No item found in the cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.items.length,
                  itemBuilder: (context, index) {
                    return CartProductWidget(
                      productId: cartController.items[index]['productId'],
                      clientId: cartController.items[index]['client_id'],
                      productColor: cartController.items[index]['color'],
                      productSize: cartController.items[index]['size'],
                      productImage: cartController.items[index]['imageURL'],
                      productTitle: cartController.items[index]['productName'],
                      productPoints: cartController.items[index]['points'],
                      deleteProduct: () {
                        // try {
                        //   await DataBaseHelper.dataBaseHelper.deleteCartOneData(
                        //       cartController.items[index]['id']);
                        //   cartController.refreshItems();
                        // } catch (e) {
                        //   print("Error deleting item: $e");
                        // }
                        cartController.deleteProductData(
                            cartController.items[index]['id']);
                      },
                      removeProductQuantity: () {
                        cartController.decreaseQuantity(
                          cartController.items[index]['id'],
                          cartController.items[index]['color'],
                          cartController.items[index]['size'],
                        );
                      },
                      addProductQuantity: () {
                        cartController.increaseQuantity(
                          cartController.items[index]['id'],
                          cartController.items[index]['color'],
                          cartController.items[index]['size'],
                        );
                      },
                      totalProduct: cartController.items[index]['quantity'],
                      currentQuantity: cartController.currentQuantity.value,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Total Points : ${cartController.totalPoints}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
      bottomNavigationBar: Obx(
        () => ElevatedButton(
          onPressed: () {
            // Check if cart is empty and navigate accordingly
            cartController.itemLength.value == 0
                ? Get.off(CategoryPage(
                    clientId: clientId,
                    clientName: clientName,
                  ))
                : Get.to(ShippingAddressPage(
                    totalPoints: cartController.totalPoints,
                    clientId: cartController.items[0]['client_id'],
                  ));
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            fixedSize: Size(
              AppConstant.size.width,
              AppConstant.size.height * 0.07,
            ),
          ),
          child: Text(
            cartController.itemLength.value == 0
                ? "Back to Categories"
                : "Add Shipping Address",
            style: TextStyle(
              color: AppColors.txtWhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
