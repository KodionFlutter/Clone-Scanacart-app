import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class CustomeFloatingButtonWidget extends StatefulWidget {
  const CustomeFloatingButtonWidget({super.key});

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
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Flow(delegate: FlowMenuDelegate(controller: controller), children: [
          IconButton(
            onPressed: () {
              // Action for the first button (0 degree)
              print('First button clicked');
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              // Action for the second button (90 degree)
              print('Second button clicked');
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // Action for the third button (180 degree)
              print('Third button clicked');
            },
            icon: Icon(Icons.lock),
          )
        ]),
        FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
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
    final yStart = size.height;

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
