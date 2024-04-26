import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/cart_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/shipping_address_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/cart_product_widget.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CartPage extends StatefulWidget {
  final int clientId;
  final String clientName;

  CartPage({super.key, required this.clientId, required this.clientName});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());
  late dynamic cartDataList;
  dynamic items;

  @override
  void initState() {
    cartDataList = DataBaseHelper.dataBaseHelper.fetchUser();
    items = cartDataList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: items,
        builder: (context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text("Connection is not Stablish"),
            );
          } else if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              print("length :: ${snapShot.data.length}");
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapShot.data.length,
                        itemBuilder: (context, index) {
                          return CartProductWidget(
                            productImage: snapShot.data[index]['productImage'],
                            productTitle: snapShot.data[index]['productTitle'],
                            productPoints: snapShot.data[index]
                                ['productPoints'],
                            onTap: () {
                              // print(
                              //     "Id : ${snapShot.data[index]['productId']}");
                              // cartController.deleteProduct(
                              //     snapShot.data[index]['productId']);
                              DataBaseHelper.dataBaseHelper
                                  .deleteCartOneData(
                                      snapShot.data[index]['productId'])
                                  .then((value) {
                                cartDataList =
                                    DataBaseHelper.dataBaseHelper.fetchUser();
                                setState(() {
                                  items = cartDataList;
                                });
                              });
                            },
                            removeCartProduct: () =>
                                cartController.removeProduct(),
                            addCartProduct: () =>
                                cartController.addMoreProduct(),
                            totalProduct: snapShot.data[index]
                                ['productQuantity'],
                            cartLength: snapShot.data.length,
                          );
                        }),
                  ),
                  snapShot.data.length != 0
                      ? const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Total Points : ${100}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              );
            }
          } else {
            return Text("data");
          }
          return Text("data");
        },
      ),

      //! Bottom -> Add Shipping Address button and Total Points ..
      bottomNavigationBar: ElevatedButton(
          onPressed: () => items != null
              ? Get.off(CategoryPage(
                  clientId: widget.clientId,
                  clientName: widget.clientName,
                ))
              : Get.to(ShippingAddressPage()),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            fixedSize:
                Size(AppConstant.size.width, AppConstant.size.height * 0.07),
          ),
          child: Text(
            items != null || items.isNotEmpty
                ? "Add Shipping Address"
                : "Back to Categories",
            style: TextStyle(
              color: AppColors.txtWhiteColor,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
