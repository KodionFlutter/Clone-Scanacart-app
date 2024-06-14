import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/Products%20Page/controller/reward_product_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_drop_down_widget.dart';

class EditRewardProduct extends StatelessWidget {
  EditRewardProduct({super.key});

  final editRewardController = Get.put(RewardProductController());

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
                                title: "Edit Product",
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
                        //! Make Here a LinearProgress Bar
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: LinearProgressIndicator(),
                        ),
                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextWidget(
                                      title: "Reward Points",
                                      size: 13,
                                      color: AppColors.blackBackgroundColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      // controller: textEditingController,
                                      keyboardType: TextInputType.number,

                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        hintText: '',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextWidget(
                                      title: "Products Quantity",
                                      size: 13,
                                      color: AppColors.blackBackgroundColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      // controller: textEditingController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        hintText: '',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 5, top: 8),
                          child: CommonTextWidget(
                            title: "Status",
                            size: 16,
                            color: AppColors.blackBackgroundColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonDropDownWidget(
                                dropDownValue:
                                    editRewardController.dropDownValue.value,
                                valueList: editRewardController.statusList),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: CommonButtonWidget(
                      onPressed: () {},
                      buttonTxt: 'Save',
                      btnHeight: 40,
                      btnWidth: 120,
                      txtColor: AppColors.whiteBackgroundColor,
                      colors: AppColors.blueColor,
                      isEnabled: true,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}