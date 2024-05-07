// order_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/controller/order_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/order_details.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);

  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Orders"),
        actions: [
          Obx(
            () => PopupMenuButton(
              initialValue: orderController.status.value,
              onSelected: (value) {
                orderController.status(value);
                orderController.getAllOrderProduct();
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                PopupMenuItem(
                  value: "Pending",
                  child: Text("Pending"),
                ),
                PopupMenuItem(
                  value: "Cancel",
                  child: Text("Cancel"),
                ),
                PopupMenuItem(
                  value: "Fulfilled",
                  child: Text("Fulfilled"),
                ),
              ],
              offset: const Offset(10, 10),
              shadowColor: Colors.black,
              color: AppColors.whiteBackgroundColor,
              elevation: 2,
            ),
          )
        ],
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return orderController.orderDataList.isEmpty
              ? Column(
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
                )
              : ListView.builder(
                  itemCount: orderController.orderDataList.length,
                  itemBuilder: (context, index) {
                    var data = orderController.orderDataList[index];
                    DateTime format = DateFormat("MMMM, d yyyy HH:mm:ss")
                        .parse(data.oRDERDATE!);
                    var date = DateFormat("dd MMM yyyy").format(format);
                    return GetBuilder<OrderController>(builder: (_){
                      return OrderWidget(
                        statusColor:
                        orderController.getStatusColor(data.orderStatus),
                        title: data.cOMPANYNAME!,
                        orderId: data.oRDERID!,
                        totalPoints: data.tOTALPOINTS!,
                        oderDate: date,
                        onPressed: () async {
                          var result = await Get.to(OrderDetails(
                            oderId: data.oRDERID!,
                          ));
                          if (result == "Canceled") {
                            orderController.updateOrderStatus(
                                data.oRDERID!, "Cancel");
                          }
                        },
                      );
                    });
                  });
        }
      }),
    );
  }
}
