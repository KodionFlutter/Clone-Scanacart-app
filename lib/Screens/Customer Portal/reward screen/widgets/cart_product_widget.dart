import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartProductWidget extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final int productPoints;
  final VoidCallback onTap, removeCartProduct, addCartProduct;
  final int totalProduct;
  final int cartLength;

  const CartProductWidget({
    Key? key,
    required this.productImage,
    required this.productTitle,
    required this.productPoints,
    required this.onTap,
    required this.removeCartProduct,
    required this.addCartProduct,
    required this.totalProduct,
    required this.cartLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: productImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: removeCartProduct,
                          child:
                          const Icon(Icons.remove_circle_outline_rounded),
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
                          onTap: addCartProduct,
                          child: const Icon(Icons.add_circle_outline_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total Points :',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$productPoints',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: -20,
            right: -5,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
