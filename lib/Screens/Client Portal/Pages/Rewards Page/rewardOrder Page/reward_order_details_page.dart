import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/controller/reward_order_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/widgets/change_status_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_address_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_dialogbox_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_item_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_totalpoints_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class RewardOrderDetailsPage extends StatelessWidget {
  RewardOrderDetailsPage({super.key});

  final controller = Get.put(RewardOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteBackgroundColor,
        elevation: 1,
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderDetailsAddressWidget(
              orderId: 1,
              date: "333",
              address: "data.address!",
              name: "data.name!",
              city: "data.city!",
              email: "data.email!",
              zipCode: "data.zipCode!",
              status: "data.orderStatus!",
              onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return addNotesMethod();
                  // orderDetailsController!.addNoteController.value.text =
                  // data.customerNotes!;
                  // return addNotesMethod();
                },
              ),
              isFielded: true,
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(15),
              width: AppConstant.size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: AppColors.orderPage,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Items".toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (ctx, i) {
                      return OrderDetailsItemWidget(
                        title: "ee",
                        quantity: 2,
                        points: 10,
                      );
                    },
                  ),
                ],
              ),
            ),
            OrderDetailsTotalPointsWidget(
              pointsAmount: 120,
              cachingCon: 0,
              discount: 0,
              totalAmount: 01,
              button: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return ChangeStatusWidget();
                        },
                      );
                    },
                    child: Text(
                      "Change Status".toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addNotesMethod() {
    return OrderDetailsDialogBoxWidget(
      title: 'Comments',
      subTitle: 'Your Note',
      textEditingController: controller.selectDateController.value,
      widget: CommonButtonWidget(
        onPressed: () async {
          // if (orderDetailsController!
          //     .addNoteController.value.text.isEmpty) {
          //   showMessage("Note can't be left blank", Colors.white);
          // } else {
          //   SharedPreferences preferences =
          //   await SharedPreferences.getInstance();
          //   var customerId = preferences.getInt("customer_id");
          //   orderDetailsController!.addNotes({
          //     "notes":
          //     orderDetailsController!.addNoteController.value.text,
          //     "order_id": oderId.toString(),
          //     "customer_id": customerId.toString()
          //   });
          // }
        },
        buttonTxt: 'Submit',
        btnHeight: AppConstant.size.height * 0.06,
        btnWidth: AppConstant.size.width * 0.5,
        txtColor: AppColors.txtWhiteColor,
        colors: Colors.lightBlue,
        isEnabled: true,
      ),
    );
  }
}