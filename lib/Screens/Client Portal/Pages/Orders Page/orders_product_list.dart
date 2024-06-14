import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/widgets/buy_again_dialogbox_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/widgets/buy_button_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/widgets/product_status_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_dialogbox_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrdersProductList extends StatelessWidget {
  final TextEditingController addCommentController;

  const OrdersProductList({super.key, required this.addCommentController});

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonTextWidget(
              title: "Order #4",
              size: 14,
              color: AppColors.greyWithOpacity,
            ),
            CommonButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return OrderDetailsDialogBoxWidget(
                        title: 'Add Comment',
                        subTitle: '',
                        textEditingController: addCommentController,
                        widget: CommonButtonWidget(
                          onPressed: () async {},
                          buttonTxt: 'Submit',
                          btnHeight: AppConstant.size.height * 0.06,
                          btnWidth: AppConstant.size.width * 0.5,
                          txtColor: AppColors.txtWhiteColor,
                          colors: Colors.lightBlue,
                          isEnabled: true,
                        ),
                      );
                    });
              },
              buttonTxt: "Delivered",
              btnHeight: 35,
              btnWidth: 120,
              txtColor: Colors.white,
              colors: Colors.blue,
              isEnabled: true,
            )
          ],
        ),
        CommonTextWidget(
          title: "Cart Packaging V1",
          size: 14,
          color: AppColors.blueColor.withOpacity(0.8),
          fontWeight: FontWeight.bold,
        ),

        //! There we make ExpansionTile

        ExpansionTile(
          collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          childrenPadding: EdgeInsets.zero,
          enabled: true,
          initiallyExpanded: false,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          maintainState: true,
          expandedAlignment: Alignment.topLeft,
          visualDensity: VisualDensity.standard,
          dense: true,
          tilePadding: EdgeInsets.zero,
          title: CommonTextWidget(
              title: 'November , 29 2022 14:54:23',
              size: 14,
              color: Colors.grey),
          children: [
            //! Status..
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductStatusWidget(
                    statusColor: AppColors.blueColor,
                    width: 25,
                    statusName: 'Design',
                    iconData: Icons.edit_off_rounded,
                    backGroundColor: Colors.blue,
                  ),
                  ProductStatusWidget(
                    statusColor: AppColors.blueColor,
                    width: 25,
                    statusName: 'Production',
                    iconData: Icons.pix_rounded,
                    backGroundColor: Colors.blue,
                  ),
                  ProductStatusWidget(
                    statusColor: AppColors.greenColor,
                    width: 25,
                    statusName: "on it's Way",
                    iconData: Icons.fire_truck_outlined,
                    backGroundColor: Colors.blue,
                  ),
                  ProductStatusWidget(
                    statusColor: AppColors.greenColor,
                    width: 0,
                    statusName: 'Delivered',
                    iconData: Icons.done,
                    backGroundColor: Colors.green,
                  )
                ],
              ),
            ),

            const Divider(
                thickness: 1, color: Colors.grey, indent: 10, endIndent: 10),

            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15, top: 5),
              child: CommonTextWidget(
                title: "Expected Date : Dec 20th 2022",
                size: 15,
                color: AppColors.blackBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: BuysButtonWidget(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return BuyAgainDialogBoxWidget();
                      });
                },
              ),
            ),
          ],
        )
      ],
    ));
  }
}