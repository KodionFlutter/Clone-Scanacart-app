import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_icon_widget.dart';

class PopMenuWidget extends StatelessWidget {
  final String productName;
  final String productImage;
  final VoidCallback onTap;

  const PopMenuWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
      icon: const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: CircleAvatar(
          child: Icon(Icons.person),
        ),
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (context) => [
        PopupMenuItem(
            padding: EdgeInsets.zero,
            child: Container(
              height: 60,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Colors.blue.shade900),
              child: Row(
                children: [
                  //! Product Image...

                  Container(
                    width: 60,
                    height: 70,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteBackgroundColor,
                    ),
                    // child: CachedNetworkImage(
                    //   imageUrl: productImage,
                    //   fit: BoxFit.contain,
                    //   placeholder: (context, url) {
                    //     return const Center(
                    //       child: CupertinoActivityIndicator(),
                    //     );
                    //   },
                    //   errorWidget: (context, url, error) {
                    //     return Material(
                    //       color: Colors.transparent.withOpacity(0.8),
                    //       child: const Center(
                    //         child: Text('Could\'t load image',
                    //             overflow: TextOverflow.visible,
                    //             textAlign: TextAlign.center,
                    //             maxLines: 2,
                    //             style: TextStyle(
                    //                 color: Colors.black, fontSize: 10)),
                    //       ),
                    //     );
                    //   },
                    // ),
                    child: Image(image: AssetImage("assets/images/blkat.png")),
                  )
                  // Icon(Icons.percent),
                  ,

                  Expanded(
                    child: Text(
                      productName.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.txtWhiteColor),
                    ),
                  )
                ],
              ),
            )),
        PopupMenuItem(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: const CustomIconWidget(
              margin: 0,
              padding: 10,
              icon: Icons.perm_contact_cal_rounded,
              iconSize: 25,
            ),
            title: const Text("My Profile"),
            subtitle: const Text(
              "Account settings and more",
              style: TextStyle(fontSize: 12),
            ),
            trailing: InkWell(
              onTap: onTap,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.blackBackgroundColor,
                size: 18,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            Get.back();
            Get.back();
          },
          padding: const EdgeInsets.all(10),
          child: const ListTile(
            leading: CustomIconWidget(
              margin: 0,
              padding: 10,
              icon: Icons.logout_outlined,
              iconSize: 25,
            ),
            title: Text("Logout"),
          ),
        ),
      ],
    );
  }
}