import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_btn_bar_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/controller/order_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/reward_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/custome_floating_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/logout_widget.dart';

class FloatingButtonPage extends StatelessWidget {
  final int customerId;
  bool? state;

  FloatingButtonPage({super.key, required this.customerId, this.state});

  final orderController = Get.put(OrderController());
  final rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    final floatingBarController =
        Get.put(FloatingBarController(customerId: customerId, state: state));
    // rewardController.getAlleMethod();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Obx(() => floatingBarController.selectedIndex.value == 1
            ? InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back))
            : SizedBox()),
        elevation: 0,
        centerTitle: true,
        title: Obx(() => floatingBarController.selectedIndex.value == 1
            ? Text("Reward")
            : Text("Order")),
        actions: [
          Obx(() => floatingBarController.selectedIndex.value == 1
              ? const LogoutWidget()
              : Obx(
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
                )),
        ],
      ),
      body: Obx(
        () => floatingBarController.pagesList
            .elementAt(floatingBarController.selectedIndex.value),
      ),
      floatingActionButton: CustomeFloatingButtonWidget(
        customerId: customerId,
        state: state,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
