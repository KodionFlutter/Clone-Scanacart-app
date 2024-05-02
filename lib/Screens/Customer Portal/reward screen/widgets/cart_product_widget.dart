import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/category_details_page.dart';

class CartProductWidget extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final String? productColor;
  final String? productSize;
  final int productPoints;
  final VoidCallback deleteProduct, removeProductQuantity, addProductQuantity;
  final int totalProduct;
  final int currentQuantity;
  final int productId;
  final int clientId;

  const CartProductWidget({
    Key? key,
    required this.productImage,
    required this.productTitle,
    required this.productPoints,
    required this.deleteProduct,
    required this.removeProductQuantity,
    required this.addProductQuantity,
    required this.totalProduct,
    required this.currentQuantity,
    this.productColor,
    this.productSize,
    required this.productId,
    required this.clientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Here the image Section

          Stack(
            children: [
              FutureBuilder<PaletteGenerator>(
                future: PaletteGenerator.fromImageProvider(
                  NetworkImage(productImage),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: 100,
                      height: 120,
                      color: Colors.grey.withOpacity(0.5), // Placeholder color
                      child: const Center(child: CupertinoActivityIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    // Handle error
                    return Container(
                      width: 100,
                      height: 120,
                      color: Colors.grey.withOpacity(0.5), // Placeholder color
                      child: const Center(child: Text('Error')),
                    );
                  } else if (snapshot.hasData) {
                    final palette = snapshot.data!.dominantColor?.color;
                    return Container(
                      padding: EdgeInsets.all(5),
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: palette!.withOpacity(0.5) ?? Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(CategoryDetailsPage(
                            productId: productId,
                            clientId: clientId,
                          ));
                        },
                        child: CachedNetworkImage(
                          width: 80,
                          imageUrl: productImage,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    );
                  } else {
                    // Handle other cases
                    return Container(
                      width: 100,
                      height: 120,
                      color: Colors.grey.withOpacity(0.5), // Placeholder color
                      child: const Center(child: Text('No Data')),
                    );
                  }
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CachedNetworkImage(
              //     width: 80,
              //     imageUrl: productImage,
              //     fit: BoxFit.contain,
              //     placeholder: (context, url) =>
              //         const CupertinoActivityIndicator(),
              //     errorWidget: (context, url, error) => const Icon(Icons.error),
              //   ),
              // ),
            ],
          ),

          // SizedBox(
          //   // height: 100,
          //   width: 80,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(12),
          //     child: CachedNetworkImage(
          //       imageUrl: productImage,
          //       fit: BoxFit.contain,
          //       placeholder: (context, url) =>
          //           const CupertinoActivityIndicator(),
          //       errorWidget: (context, url, error) => const Icon(Icons.error),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              // height: 100,
              // color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    productTitle.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  //!  Display the Color of the Product ..
                  productColor == null || productColor!.isEmpty
                      ? const SizedBox()
                      : RichText(
                          text: TextSpan(
                            text: "Color : ",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "$productColor",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 2),
                  //! Display the Size of the Product..
                  productSize == null || productSize!.isEmpty
                      ? const SizedBox()
                      : RichText(
                          text: TextSpan(
                            text: "Size   : ",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "$productSize",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 10),
                  // RichText(
                  //   text: TextSpan(
                  //     text: "Total Points : ",
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: "$productPoints",
                  //         style: const TextStyle(
                  //           color: Colors.blue,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      InkWell(
                        onTap: removeProductQuantity,
                        child: const Icon(Icons.remove_circle_outline_rounded),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$totalProduct',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: addProductQuantity,
                        child: const Icon(Icons.add_circle_outline_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //! Make here the Update and remove Product Quantity..
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: const BorderRadius.only(
                          // topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(5))),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Total Points : ",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "$productPoints",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),
                // Delete Button ..

                InkWell(
                  onTap: deleteProduct,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),

                // ElevatedButton(
                //     onPressed: deleteProduct,
                //     style: ElevatedButton.styleFrom(
                //         // shape: RoundedRectangleBorder(
                //         //   borderRadius: BorderRadius.circular(4)
                //         // )
                //         elevation: 0,
                //         backgroundColor: Colors.transparent,
                //         side: const BorderSide(
                //             color: Colors.redAccent, width: 1)),
                //     child: const Icon(
                //       Icons.delete_outline,
                //       color: Colors.red,
                //     )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
