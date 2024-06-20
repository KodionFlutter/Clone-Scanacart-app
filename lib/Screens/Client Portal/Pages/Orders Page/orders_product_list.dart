import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

class OrdersProductList extends StatelessWidget {
  final TextEditingController addCommentController;
  final String trackingID;
  final String trackingNum;
  final String updateDt;
  final String status;
  final String eta;
  final VoidCallback onPressed;
  final Widget buysButton;
  final Function(bool)? onExpansionChanged;
  final List<Widget> statusWidget;
  final String keys;
  final bool initiallyExpanded;

  const OrdersProductList(
      {super.key,
      required this.addCommentController,
      required this.trackingID,
      required this.trackingNum,
      required this.updateDt,
      required this.status,
      required this.onPressed,
      required this.eta,
      required this.buysButton,
      this.onExpansionChanged,
      required this.statusWidget,
      required this.keys,
      required this.initiallyExpanded});

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
              title: "Order #$trackingID",
              size: 14,
              color: AppColors.greyWithOpacity,
            ),
            // CommonButtonWidget(
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (_) {
            //           return OrderDetailsDialogBoxWidget(
            //             title: 'Add Comment',
            //             subTitle: '',
            //             textEditingController: addCommentController,
            //             widget: CommonButtonWidget(
            //               onPressed: () async {},
            //               buttonTxt: 'Submit',
            //               btnHeight: AppConstant.size.height * 0.06,
            //               btnWidth: AppConstant.size.width * 0.5,
            //               txtColor: AppColors.txtWhiteColor,
            //               colors: Colors.lightBlue,
            //               isEnabled: true,
            //             ),
            //           );
            //         });
            //   },
            //   buttonTxt: "$status",
            //   btnHeight: 35,
            //   btnWidth: AppConstant.size.width * 0.2,
            //   txtColor: Colors.white,
            //   colors: Colors.blue,
            //   isEnabled: true,
            // ) ,
            ElevatedButton(
              onPressed: onPressed,
              child: CommonTextWidget(
                title: status,
                size: 14,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
          ],
        ),
        CommonTextWidget(
          title: trackingNum,
          size: 14,
          color: AppColors.blueColor.withOpacity(0.8),
          fontWeight: FontWeight.bold,
        ),

        //! There we make ExpansionTile

        ExpansionTile(
          key: Key(keys),
          collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          onExpansionChanged: onExpansionChanged,
          childrenPadding: EdgeInsets.zero,
          enabled: true,
          initiallyExpanded: initiallyExpanded,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          maintainState: true,
          expandedAlignment: Alignment.topLeft,
          visualDensity: VisualDensity.standard,
          dense: true,
          tilePadding: EdgeInsets.zero,
          title: CommonTextWidget(
              title: updateDt, size: 14, color: Colors.grey),
          children: [
            //! Status..
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: statusWidget,
              ),
            ),

            const Divider(
                thickness: 1, color: Colors.grey, indent: 10, endIndent: 10),

            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15, top: 5),
              child: CommonTextWidget(
                title: "Expected Date : $eta",
                size: 15,
                color: AppColors.blackBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(alignment: Alignment.centerRight, child: buysButton),
          ],
        )
      ],
    ));
  }
}
