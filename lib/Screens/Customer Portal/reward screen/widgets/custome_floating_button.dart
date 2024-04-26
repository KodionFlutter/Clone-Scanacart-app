import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Floating%20bottom%20bar/floating_btn_bar_controller.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/scan_nfc_screen.dart';

class CustomeFloatingButtonWidget extends StatefulWidget {
  final int customerId;
  bool? state;

   CustomeFloatingButtonWidget({super.key, required this.customerId , this.state});

  @override
  State<CustomeFloatingButtonWidget> createState() =>
      _CustomeFloatingButtonWidgetState();
}

class _CustomeFloatingButtonWidgetState
    extends State<CustomeFloatingButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final barcontroller =
        Get.put(FloatingBarController(customerId: widget.customerId));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Flow(
          clipBehavior: Clip.hardEdge,
          delegate: FlowMenuDelegate(controller: controller),
          children: [
            CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: InkWell(
                  onTap: ()=> {
                    barcontroller.onCheckIndex(0),
                    controller.reverse(),
                  },
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                )),
            CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: InkWell(
                  onTap: () => {
                    barcontroller.onCheckIndex(1),
                    controller.reverse(),
                  },
                  child: Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                  ),
                )),
            CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: InkWell(
                  onTap: () {
                    barcontroller.onCheckIndex(2);
                    controller.reverse();
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                )),
            FloatingActionButton(
              backgroundColor: AppColors.txtScanProductColor,
              onPressed: () {
                if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
              elevation: 0,
              splashColor: Colors.black,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                color: AppColors.txtWhiteColor,
                size: 30,
                progress: controller,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width / 2;
    final yStart = size.height / 1.1;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;
      double theta = 0;

      if (n == 1) {
        theta = 0;
      } else if (n == 2) {
        theta = (i == 0) ? 0 : pi / 2;
      } else {
        theta = i * pi / 2;
      }

      final radius = 90 * controller.value;
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));

      final angle = isLastItem ? 0.0 : 180 * (1 - controller.value);
      final scale = isLastItem ? 1.0 : max(controller.value, 0.8);

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(50 / 2, 50 / 2)
            ..rotateZ(angle * pi / 180)
            ..scale(scale)
            ..translate(-50 / 2, -50 / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
