import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppbarWidget extends StatelessWidget {
  final String imagePath;

  AppbarWidget({Key? key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    print("Image path => $imagePath");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          height: 90,
          width: 125,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 5),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) {
                return Material(
                  color: Colors.transparent.withOpacity(0.8),
                  child:const Center(
                    child: Text(
                      'Could not load image',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
