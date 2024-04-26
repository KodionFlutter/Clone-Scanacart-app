import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_btn_bar_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/custome_floating_button.dart';

class FloatingButtonPage extends StatelessWidget {
  final int customerId;
  bool? state;

  FloatingButtonPage({super.key, required this.customerId, this.state});

  @override
  Widget build(BuildContext context) {
    final floatingBarController =
        Get.put(FloatingBarController(customerId: customerId , state: state));

    return Scaffold(
      body: Obx(() => floatingBarController.pagesList
          .elementAt(floatingBarController.selectedIndex.value)),
      floatingActionButton: CustomeFloatingButtonWidget(
        customerId: customerId,
        state: state,
      ),
    );
  }
}
