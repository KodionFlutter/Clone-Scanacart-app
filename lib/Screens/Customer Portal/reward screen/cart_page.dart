import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      // body: GetBuilder<CartController>(
      //   builder: (cartController) {
      // if (cartController.items.isEmpty) {
      //   return const Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         CupertinoActivityIndicator(),
      //         SizedBox(height: 20),
      //         Text(
      //           "No item found in the cart",
      //           style: TextStyle(fontWeight: FontWeight.bold),
      //         )
      //       ],
      //     ),
      //   );
      // } else {
      //   return Column(
      //     children: [
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: cartController.items.length,
      //           itemBuilder: (context, index) {
      //             return CartProductWidget(
      //               productColor: cartController.items[index]['productColor'],
      //               productSize: cartController.items[index]['productSize'],
      //               productImage: cartController.items[index]['productImage'],
      //               productTitle: cartController.items[index]['productTitle'],
      //               productPoints: cartController.items[index]['productPoints'],
      //               deleteProduct: () async {
      //                 try {
      //                   await DataBaseHelper.dataBaseHelper.deleteCartOneData(
      //                       cartController.items[index]['id']
      //                   );
      //                   // Refresh items after successful deletion
      //                   cartController.refreshItems();
      //                 } catch (e) {
      //                   // Handle any errors that might occur during deletion
      //                   print("Error deleting item: $e");
      //                 }
      //               },
      //               removeProductQuantity: () {
      //                 cartController.decreaseQuantity(
      //                   cartController.items[index]['id'],
      //                   cartController.items[index]['productColor'],
      //                   cartController.items[index]['productSize'],
      //                 );
      //               },
      //               addProductQuantity: () {
      //                 cartController.increaseQuantity(
      //                   cartController.items[index]['id'],
      //                   cartController.items[index]['productColor'],
      //                   cartController.items[index]['productSize'],
      //                 );
      //               },
      //               totalProduct: cartController.items[index]['productQuantity'],
      //               cartLength: cartController.items.length,
      //             );
      //           },
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(right: 20),
      //         child: Align(
      //           alignment: Alignment.centerRight,
      //           child: Text(
      //             "Total Points : ${cartController.totalPoints}",
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: 18,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   );
      // }
      // },
      // ),
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
                      productColor: cartController.items[index]['productColor'],
                      productSize: cartController.items[index]['productSize'],
                      productImage: cartController.items[index]['productImage'],
                      productTitle: cartController.items[index]['productTitle'],
                      productPoints: cartController.items[index]
                          ['productPoints'],
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
                          cartController.items[index]['productColor'],
                          cartController.items[index]['productSize'],
                        );
                      },
                      addProductQuantity: () {
                        cartController.increaseQuantity(
                          cartController.items[index]['id'],
                          cartController.items[index]['productColor'],
                          cartController.items[index]['productSize'],
                        );
                      },
                      totalProduct: cartController.items[index]
                          ['productQuantity'],
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
                : Get.to(ShippingAddressPage());
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
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
