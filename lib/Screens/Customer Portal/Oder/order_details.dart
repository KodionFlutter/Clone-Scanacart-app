import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/controller/oder_details_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_address_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_dialogbox_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_item_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_totalpoints_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/constant.dart';

class OrderDetails extends StatelessWidget {
  final int oderId;

  const OrderDetails({Key? key, required this.oderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderDetailsController =
        Get.put(OrderDetailsController(oderId: oderId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Order Detail"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (orderDetailsController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (orderDetailsController.orderDetailsDataList.isEmpty) {
            return Column(
              children: [
                SizedBox(height: AppConstant.size.height * 0.1),
                Image.asset(
                  "assets/images/record.webp",
                  fit: BoxFit.contain,
                  height: AppConstant.size.height * 0.3,
                  width: AppConstant.size.width,
                ),
                SizedBox(height: AppConstant.size.height * 0.01),
                Text(
                  "No order Found".toUpperCase(),
                  style: TextStyle(
                      fontSize: AppConstant.size.height * 0.020,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: orderDetailsController.orderDetailsDataList.length,
              itemBuilder: (context, index) {
                var data = orderDetailsController.orderDetailsDataList[index];
                var itemDetails = orderDetailsController
                    .orderDetailsDataList[index].orderitem;
                DateTime format =
                    DateFormat("MMMM, d yyyy HH:mm:ss").parse(data.orderDate!);
                var date = DateFormat("dd MMM yyyy").format(format);
                return Column(
                  children: [
                    OrderDetailsAddressWidget(
                      orderId: data.orderId!,
                      date: date,
                      address: data.address!,
                      name: data.name!,
                      city: data.city!,
                      email: data.email!,
                      zipCode: data.zipCode!,
                      status: data.orderStatus!,
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) {
                          orderDetailsController.addNoteController.value.text =
                              data.customerNotes!;
                          return OrderDetailsDialogBoxWidget(
                            title: 'Comments',
                            subTitle: 'Your Note',
                            textEditingController:
                                orderDetailsController.addNoteController.value,
                            onPressed: () async {
                              if (orderDetailsController
                                  .addNoteController.value.text.isEmpty) {
                                showMessage(
                                    "Note can't be left blank", Colors.white);
                              } else {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                var customerId =
                                    preferences.getInt("customer_id");
                                orderDetailsController.addNotes({
                                  "notes": orderDetailsController
                                      .addNoteController.value.text,
                                  "order_id": oderId.toString(),
                                  "customer_id": customerId.toString()
                                }).then((value) {
                                  orderDetailsController.getOrderDetails();
                                  Get.back();
                                });
                              }
                            },
                          );
                        },
                      ),
                      isFielded: data.customerNotes!.isEmpty ? false : true,
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(15),
                      width: AppConstant.size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: AppColors.orderPage,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Items".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemDetails!.length,
                            itemBuilder: (ctx, i) {
                              return OrderDetailsItemWidget(
                                title: itemDetails[i]
                                    .productName![0]
                                    .productTitle!,
                                quantity: itemDetails[i].quantity!,
                                points: itemDetails[i].pointsUsed!,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    OrderDetailsTotalPointsWidget(
                      pointsAmount: data.totalPoints!,
                      cachingCon: 0,
                      discount: 0,
                      totalAmount: data.totalPoints!,
                      button: data.orderStatus == 'Cancel'
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: SizedBox()),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return OrderDetailsDialogBoxWidget(
                                          title: 'Cancel order',
                                          subTitle: 'Reason',
                                          textEditingController:
                                              orderDetailsController
                                                  .cancelNoteController.value,
                                          onPressed: () {
                                            orderDetailsController
                                                .cancelOrderProduct({
                                              "reason": orderDetailsController
                                                  .cancelNoteController
                                                  .value
                                                  .text,
                                              'order_id': oderId.toString(),
                                            }).then((value) {
                                              orderDetailsController
                                                  .getOrderDetails();
                                              Get.back();
                                            });
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "cancel order".toUpperCase(),
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
