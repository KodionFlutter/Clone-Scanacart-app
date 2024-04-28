import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer Portal/reward screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Screens/Customer Portal/reward screen/widgets/cart_product_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/shipping_address_page.dart';
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
        body: GetBuilder<CartController>(
          builder: (cartController) {
            if (cartController.items.isEmpty) {
              return  const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(),
                    SizedBox(height: 20),
                    Text("No item found in the cart" , style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              );
            } else {
              print("length :: ${cartController.items.length}");
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartController.items.length,
                        itemBuilder: (context, index) {
                          print("Index : $index");
                          cartController.itemLength.value =
                              cartController.items.length;
                          return CartProductWidget(
                            productImage: cartController.items[index]
                                ['productImage'],
                            productTitle: cartController.items[index]
                                ['productTitle'],
                            productPoints: cartController.items[index]
                                ['productPoints'],
                            onTap: () => cartController.deleteProduct(
                                cartController.items[index]['productId']),
                            removeCartProduct: () {
                              cartController.decreaseQuantity(
                                  cartController.items[index]['productId'],
                                  index);
                            },
                            addCartProduct: () {
                              cartController.increaseQuantity(
                                  cartController.items[index]['productId']);
                            },
                            totalProduct: cartController.items[index]
                                ['productQuantity'],
                            cartLength: cartController.items.length,
                          );
                        }),
                  ),
                  cartController.items.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Total Points : ${cartController.totalPoints}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: Obx(
          () => ElevatedButton(
              onPressed: () {
                cartController.itemLength.value == 0  && cartController.currentClientID == clientId
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
                    AppConstant.size.width, AppConstant.size.height * 0.07),
              ),
              child: Text(
                cartController.itemLength.value != 0 &&  cartController.currentClientID == clientId
                    ? "Add Shipping Address"
                    : "Back to Categories",
                style: TextStyle(
                  color: AppColors.txtWhiteColor,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              )),
        ));
  }
}
