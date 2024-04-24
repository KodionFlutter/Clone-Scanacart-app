import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CartCounterWidget extends StatelessWidget {
  final int itemCount;
  const CartCounterWidget({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    var list = [1,1];
    return Padding(
        padding:  EdgeInsets.only(left: 10, right:  18, top: 10),
        child: SizedBox(
            height: 150.0,
            width: 30.0,
            child: GestureDetector(
              onTap: () {},
              child: Stack(
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
                          top: itemCount > 998 ? -9 :-2,
                          right: -14,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius:itemCount > 998 ? 14 :  10,
                                backgroundColor: Colors.red,
                                child: Center(
                                  child: Text(
                                    itemCount.toString(),
                                    style:  TextStyle(
                                        color: AppColors.whiteBackgroundColor,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )),
                ],
              ),
            )));
  }
}
