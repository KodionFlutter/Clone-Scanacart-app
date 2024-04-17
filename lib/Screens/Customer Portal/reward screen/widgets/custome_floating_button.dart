import 'dart:math';

import 'package:flutter/material.dart';

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
    return Flow(
      delegate: FlowMenuDelegate(controller: controller),
      children: <IconData>[
        Icons.home,
        Icons.edit,
        Icons.lock,
        Icons.menu,
      ].map<Widget>(buildFAB).toList(),
    );
  }

  Widget buildFAB(IconData icon) => SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          elevation: 0,
          splashColor: Colors.black,
          child: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
        ),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
     final size = context.size;
     final xStart = size.width - 170;
     final yStart = size.height -60;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;
      final radius = 90 * controller.value;
      final theta = i * pi * 0.8 / (n - 2);
      final x =xStart -  setValue(radius * cos(theta));
      final y =yStart- setValue(radius * sin(theta));

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(50 / 2, 50 / 2)
            ..rotateZ(isLastItem? 0.0 :  180 * (1 - controller.value) * pi / 180)
            ..scale(isLastItem? 1.0 :  max(controller.value, 0.5))
            ..translate(-50 / 2, -50 / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}