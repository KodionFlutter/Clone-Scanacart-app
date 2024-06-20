import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/controller/order_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/order_details.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_page_loading_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    orderController.getAllOrderProduct();
    return Obx(() {
      if (orderController.isLoading.value) {
        return const Center(
          child: OrderPageLoadingPageWidget(),
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
                  return GetBuilder<OrderController>(builder: (_) {
                    return OrderWidget(
                      statusColor:
                          orderController.getStatusColor(data.orderStatus),
                      title: data.cOMPANYNAME!,
                      orderId: data.oRDERID!,
                      totalPoints: data.tOTALPOINTS!,
                      oderDate: date,
                      onPressed: () async {
                        await Get.to(OrderDetails(
                          oderId: data.oRDERID!,
                        ))!
                            .then((value) =>
                                orderController.getAllOrderProduct());
                      },
                    );
                  });
                });
      }
    });
  }
}
