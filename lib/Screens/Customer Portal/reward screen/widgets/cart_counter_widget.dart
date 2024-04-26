import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/cart_page.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';

class CartCounterWidget extends StatefulWidget {
  final int itemCount;
  final int clientId;
  final String clientName;

  const CartCounterWidget(
      {super.key,
      required this.itemCount,
      required this.clientId,
      required this.clientName});

  @override
  State<CartCounterWidget> createState() => _CartCounterWidgetState();
}

class _CartCounterWidgetState extends State<CartCounterWidget> {
  late dynamic cartDataList;
  dynamic items;

  @override
  void initState() {
    cartDataList = DataBaseHelper.dataBaseHelper.fetchProduct();
    items = cartDataList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = [1, 1];
    return Padding(
        padding: const  EdgeInsets.only(left: 10, right: 18, top: 10),
        child: SizedBox(
            height: 150.0,
            width: 30.0,
            child: GestureDetector(
              onTap: () {
                Get.to(CartPage(
                  clientId: widget.clientId,
                  clientName: widget.clientName,
                ));
              },
              child: FutureBuilder(
                future: items,
                builder: (context, AsyncSnapshot snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapShot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text("Connection is not Establish"),
                    );
                  } else if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      print("length :: ${snapShot.data.length}");
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                items = cartDataList;
                              });
                            },
                          ),
                          Positioned(
                              top: widget.itemCount > 998 ? -9 : -2,
                              right: -14,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: widget.itemCount > 998 ? 14 : 10,
                                    backgroundColor: Colors.red,
                                    child: Center(
                                      child: Text(
                                        snapShot.data.length == 0
                                            ? "0"
                                            : "${snapShot.data[0]['productQuantity']}",
                                        style: TextStyle(
                                            color:
                                                AppColors.whiteBackgroundColor,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      );
                    }
                  } else {
                    return const Text("data");
                  }
                  return const Text("data");
                },
              ),
            )));
  }
}
