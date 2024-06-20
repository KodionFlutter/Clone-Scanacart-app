import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/controller/clinet_order_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/orders_product_list.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/widgets/buy_again_dialogbox_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/widgets/buy_button_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/widgets/product_status_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_search_bar_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_dialogbox_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class ClientOrdersPage extends StatelessWidget {
  ClientOrdersPage({super.key});

  final clientOrderController = Get.put(ClientOrdersController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Here are search bar

        CustomSearchBarWidget(
          onChanged: () {
            //! Here we apply for search the Item
            clientOrderController.onQueryChanged(
                clientOrderController.searchController.value.text);
          },
          controller: clientOrderController.searchController.value,
        ),

        //! Here are the List ..

        Expanded(
          child: ScrollConfiguration(
            behavior: CommonScrollBehaveWidget(),
            child: Obx(() => clientOrderController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : clientOrderController.trackingList.isEmpty
                    ? const Center(
                        child: Text("No Order Found"),
                      )
                    : ListView.builder(
                        itemCount: clientOrderController.trackingList.length,
                        itemBuilder: (context, index) {
                          return OrdersProductList(
                            addCommentController: clientOrderController
                                .addCommentController.value,
                            trackingID:
                                '${clientOrderController.trackingList[index]['tracking_id']}',
                            trackingNum:
                                '${clientOrderController.trackingList[index]['tracking_num']}',
                            updateDt:
                                '${clientOrderController.trackingList[index]['create_dt']}',
                            status:
                                '${clientOrderController.trackingList[index]['status']}',
                            keys: index.toString(),
                            initiallyExpanded:
                                index == clientOrderController.selected,
                            onExpansionChanged: (value) {
                              if (value) {
                                clientOrderController.selected = index;
                                print(
                                    " 11fff ${clientOrderController.selected}");
                              } else {
                                clientOrderController.selected = -1;
                                clientOrderController
                                    .expansionTileControllerLanguage.value
                                    .collapse();
                                print(
                                    "ooo = >>>${clientOrderController.selected} ");
                              }
                            },
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return OrderDetailsDialogBoxWidget(
                                      title: 'Add Comment',
                                      subTitle: '',
                                      textEditingController:
                                          clientOrderController
                                              .addCommentController.value,
                                      widget: CommonButtonWidget(
                                        onPressed: () async {},
                                        buttonTxt: 'Submit',
                                        btnHeight:
                                            AppConstant.size.height * 0.06,
                                        btnWidth: AppConstant.size.width * 0.5,
                                        txtColor: AppColors.txtWhiteColor,
                                        colors: Colors.lightBlue,
                                        isEnabled: true,
                                      ),
                                    );
                                  });
                            },
                            eta:
                                '${clientOrderController.trackingList[index]['ETA']}',
                            buysButton: clientOrderController
                                        .trackingList[index]['status'] ==
                                    "Delivered"
                                ? BuysButtonWidget(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return const BuyAgainDialogBoxWidget();
                                          });
                                    },
                                  )
                                : const SizedBox(),
                            statusWidget: (clientOrderController
                                            .trackingList[index]['status'] ==
                                        "Delivered" ||
                                    clientOrderController.trackingList[index]
                                            ['status'] ==
                                        "Design")
                                ? [
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
                                      iconData: Icons.corporate_fare_sharp,
                                      backGroundColor: Colors.blue,
                                    ),
                                    ProductStatusWidget(
                                      statusColor: AppColors.greenColor,
                                      width: 25,
                                      statusName: "on it's Way",
                                      iconData: Icons.airport_shuttle_outlined,
                                      backGroundColor: Colors.blue,
                                    ),
                                    ProductStatusWidget(
                                      statusColor: AppColors.greenColor,
                                      width: 0,
                                      statusName: 'Delivered',
                                      iconData: Icons.done,
                                      backGroundColor: Colors.green,
                                    )
                                  ]
                                : [
                                    ProductStatusWidget(
                                      statusColor: AppColors.blueColor,
                                      width: 25,
                                      statusName: 'Design',
                                      iconData: Icons.edit_off_rounded,
                                      backGroundColor: Colors.blue,
                                    ),
                                    const ProductStatusWidget(
                                      statusColor: Colors.grey,
                                      width: 25,
                                      statusName: 'Production',
                                      iconData: Icons.refresh,
                                      backGroundColor: Colors.grey,
                                    ),
                                    const ProductStatusWidget(
                                      statusColor: Colors.grey,
                                      width: 25,
                                      statusName: "on it's Way",
                                      iconData: Icons.refresh,
                                      backGroundColor: Colors.grey,
                                    ),
                                    ProductStatusWidget(
                                      statusColor: AppColors.greenColor,
                                      width: 0,
                                      statusName: 'Delivered',
                                      iconData: Icons.refresh,
                                      backGroundColor: Colors.grey,
                                    )
                                  ],
                          );
                        })),
          ),
        ),
      ],
    );
  }
}
