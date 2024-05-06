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

  const OrderDetails({super.key, required this.oderId});

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
        () => orderDetailsController.orderDetailsDataList.isEmpty
            ? Center(child: CupertinoActivityIndicator())
            : orderDetailsController.isLoaded.value == false
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        orderDetailsController.orderDetailsDataList.length,
                    itemBuilder: (context, index) {
                      var data =
                          orderDetailsController.orderDetailsDataList[index];
                      var itemDetails = orderDetailsController
                          .orderDetailsDataList[index].orderitem;
                      DateTime format = DateFormat("MMMM, d yyyy HH:mm:ss")
                          .parse(data.orderDate!);
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
                                  orderDetailsController.addNoteController.value
                                      .text = data.customerNotes!;
                                  return OrderDetailsDialogBoxWidget(
                                    title: 'Comments',
                                    subTitle: 'Your Note',
                                    textEditingController:
                                        orderDetailsController
                                            .addNoteController.value,
                                    onPressed: () async {
                                      if (orderDetailsController
                                          .addNoteController
                                          .value
                                          .text
                                          .isEmpty) {
                                        showMessage("Note can't be left blank",
                                            Colors.white);
                                      } else {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var customerId =
                                            preferences.getInt("customer_id");
                                        orderDetailsController.addNotes({
                                          "notes": orderDetailsController
                                              .addNoteController.value.text,
                                          "order_id": data.orderId.toString(),
                                          "customer_id": customerId.toString()
                                        }).then((value) {
                                          orderDetailsController
                                              .getOrderDetails();
                                          Get.back();
                                        });
                                      }
                                    },
                                  );
                                }),
                            isFielded:
                                data.customerNotes!.isEmpty ? false : true,
                          ),

                          //! Items List

                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(15),
                            width: AppConstant.size.width * 1,
                            // height: AppConstant.size.height*1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColors.orderPage,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! Order Details
                                Text("Items".toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(height: 10),
                                //! ListTile ..
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
                                    })
                              ],
                            ),
                          ),

                          //! Here show the  All amount ..

                          OrderDetailsTotalPointsWidget(
                            pointsAmount: data.totalPoints!,
                            cachingCon: 0,
                            discount: 0,
                            totalAmount: data.totalPoints!,
                            onTap: () {
                              //! Here we call the cancel order api..
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
                                        orderDetailsController.isLoaded.value =
                                            false;
                                        //! Her we call the cancel method
                                        orderDetailsController
                                            .cancelOrderProduct({
                                          "reason": orderDetailsController
                                              .cancelNoteController.value.text,
                                          'order_id': data.orderId!.toString(),
                                        }).then((value) {
                                          Get.back();

                                          orderDetailsController
                                              .getOrderDetails();
                                          orderDetailsController
                                              .isLoaded.value = true;
                                        });
                                      },
                                    );
                                  });
                            },
                          ),
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
