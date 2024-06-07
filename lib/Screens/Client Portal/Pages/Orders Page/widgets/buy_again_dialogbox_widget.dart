import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';

class BuyAgainDialogBoxWidget extends StatelessWidget {
  const BuyAgainDialogBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return IntrinsicHeight(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 3, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget(
                                title: "Recorder Cart Packaging V1",
                                size: 15,
                                color: AppColors.blackBackgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                              IconButton(
                                iconSize: 20,
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 5),
                        Divider(
                          thickness: 1,
                          color: AppColors.greyWithOpacity,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, bottom: 5, top: 5),
                          child: CommonTextWidget(
                            title: "Product Type",
                            size: 15,
                            color: AppColors.blackBackgroundColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: CommonTextWidget(
                            title: "Label",
                            size: 15,
                            color: AppColors.blackBackgroundColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 5, top: 10),
                          child: CommonTextWidget(
                            title: "Quantity",
                            size: 16,
                            color: AppColors.blackBackgroundColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextFormField(
                            // controller: textEditingController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 5, top: 8),
                          child: CommonTextWidget(
                            title: "New Comment",
                            size: 16,
                            color: AppColors.blackBackgroundColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextFormField(
                            // controller: textEditingController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Enter Comment...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Divider(
                          thickness: 1,
                          color: AppColors.greyWithOpacity,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {},
                        child: const Center(
                          child: Text(
                            'Order',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}