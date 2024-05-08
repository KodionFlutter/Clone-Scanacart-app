import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer Portal/reward screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Screens/Customer Portal/reward screen/widgets/cart_product_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/shipping_address_page.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatelessWidget {
  final int clientId;
  final String clientName;

  CartPage({Key? key, required this.clientId, required this.clientName})
      : super(key: key);

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return cartController.items.length == 0
              ? Column(
                  children: [
                    SizedBox(height: AppConstant.size.height * 0.1),
                    Image.asset(
                      "assets/images/record.webp",
                      fit: BoxFit.contain,
                      height: AppConstant.size.height * 0.3,
                      width: AppConstant.size.width,
                    ),
                    SizedBox(height: AppConstant.size.height * 0.01),
                    Text(
                      "No Cart Item Found".toUpperCase(),
                      style: TextStyle(
                          fontSize: AppConstant.size.height * 0.020,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartController.items.length,
                        itemBuilder: (context, index) {
                          print("Cart length : ${cartController.items.length}");
                          return CartProductWidget(
                            productId: cartController.items[index]['productId'],
                            clientId: cartController.items[index]['client_id'],
                            productColor: "",
                            productSize: "",
                            productImage: cartController.items[index]
                                ['imageURL'],
                            productTitle: cartController.items[index]
                                ['productName'],
                            productPoints: cartController.items[index]
                                ['points'],
                            deleteProduct: () {
                              cartController.deleteProductData(
                                  cartController.items[index]['id']);
                            },
                            removeProductQuantity: () {
                              cartController.decreaseQuantity(
                                  cartController.items[index]['id'],
                                  cartController.items[index]['variants']);
                            },
                            addProductQuantity: () {
                              cartController.increaseQuantity(
                                cartController.items[index]['id'],
                                cartController.items[index]['variants'],
                              );
                            },
                            totalProduct: cartController.items[index]
                                ['quantity'],
                            currentQuantity:
                                cartController.currentQuantity.value,
                            clientName: clientName,
                            // widget: Container(
                            //   height: 100,
                            //   width: 100,
                            //   color: cartController.colorsList.isNotEmpty
                            //       ? cartController.colorsList[index].color
                            //       : Colors.grey,
                            // ),
                            // widget: cartController.isImageLoading.value
                            //     ? Center(
                            //         child: CupertinoActivityIndicator())
                            //     : Container(
                            //         padding: const EdgeInsets.all(5),
                            //         width: 100,
                            //         height: 120,
                            //         decoration: BoxDecoration(
                            //           borderRadius: const BorderRadius.only(
                            //             topLeft: Radius.circular(10),
                            //             bottomLeft: Radius.circular(10),
                            //           ),
                            //           // color: cartController
                            //           //         .colorsList.isNotEmpty
                            //           //     ? cartController
                            //           //         .colorsList[index].color
                            //           //     :
                            //         color:   Colors.grey,
                            //         ),
                            //         child: InkWell(
                            //           onTap: () {
                            //             Get.to(CategoryDetailsPage(
                            //               productId: 0,
                            //               clientId: clientId,
                            //               clientName: clientName,
                            //             ));
                            //           },
                            //           child: CachedNetworkImage(
                            //             width: 80,
                            //             imageUrl: cartController
                            //                 .items[index]['imageURL'],
                            //             fit: BoxFit.contain,
                            //             placeholder: (context, url) =>
                            //                 const CupertinoActivityIndicator(),
                            //             errorWidget:
                            //                 (context, url, error) =>
                            //                     const Icon(Icons.error),
                            //           ),
                            //         ),
                            //       ),
                            widget: SizedBox(),
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
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              int? backFlag = preferences.getInt("BackFlag");
              // Check if cart is empty and navigate accordingly
              if (cartController.items.isEmpty &&
                  cartController.items.length == 0) {
                if (backFlag == 1) {
                  Get.back();
                } else if (backFlag == 2) {
                  Get.back();
                  Get.back();
                } else if (backFlag == 3) {
                  Get.back();
                  Get.back();
                  Get.back();
                }
                preferences.remove("BackFlag");
              } else if (clientId != cartController.items[0]['client_id']) {
                if (backFlag == 1) {
                  Get.back();
                } else if (backFlag == 2) {
                  Get.back();
                  Get.back();
                } else if (backFlag == 3) {
                  Get.back();
                  Get.back();
                  Get.back();
                }
                preferences.remove("BackFlag");
              } else {
                Get.to(ShippingAddressPage(
                  totalPoints: cartController.totalPoints,
                  clientId: cartController.items[0]['client_id'],
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: clientId != cartController.sameClient.value
                  ? Colors.black12
                  : Colors.blue,
              fixedSize: Size(
                AppConstant.size.width,
                AppConstant.size.height * 0.07,
              ),
            ),
            child: cartController.items.isEmpty
                ? Text(
                    "Back to Categories",
                    style: TextStyle(
                      color: AppColors.txtWhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    clientId != cartController.sameClient.value
                        ? "Back to Categories"
                        : "Add Shipping Address",
                    style: TextStyle(
                      color: AppColors.txtWhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
      ),
    );
  }
}
