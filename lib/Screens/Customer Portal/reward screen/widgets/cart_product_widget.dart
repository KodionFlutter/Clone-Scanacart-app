import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CartProductWidget extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final int productPoints;
  final VoidCallback onTap, removeCartProduct, addCartProduct;
  final int totalProduct;
  final int cartLength;

  const CartProductWidget(
      {super.key,
      required this.productImage,
      required this.productTitle,
      required this.productPoints,
      required this.onTap,
      required this.removeCartProduct,
      required this.addCartProduct,
      required this.totalProduct,
      required this.cartLength});

  @override
  Widget build(BuildContext context) {
    return cartLength == 0
        ? Center(
            child: Text(
              "No item into the cart",
              style: TextStyle(color: Colors.blue),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //! Product Image ..

                    CachedNetworkImage(
                      height: 60,
                      width: 60,
                      imageUrl: productImage,
                      fit: BoxFit.contain,
                      placeholder: (context, url) {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Material(
                          color: Colors.transparent.withOpacity(0.8),
                          child: const Center(
                            child: Text('Could\'t load image',
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text("$productTitle",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    //! Product Title  and the item quantity add or remove button ..
                    Row(
                      children: [
                        InkWell(
                          onTap: removeCartProduct,
                          child: Text("-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        SizedBox(width: 10),
                        Text("$totalProduct"),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () => addCartProduct,
                          child: Text("+",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total Points : $productPoints",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      child: InkWell(
                          onTap: onTap,
                          child: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
                const Divider(thickness: 1, color: Colors.grey)
              ],
            ),
          );
  }
}
