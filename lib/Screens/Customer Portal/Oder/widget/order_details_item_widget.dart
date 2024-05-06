import 'package:flutter/material.dart';

class OrderDetailsItemWidget extends StatelessWidget {
  final String title;
  final int quantity;
  final int points;

  const OrderDetailsItemWidget(
      {super.key,
      required this.title,
      required this.quantity,
      required this.points});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Image(
        height: 45,
        image: AssetImage('assets/images/point.png'),
      ),
      title: Text("$title"),
      subtitle: Text("Quantity: $quantity ,"),
      trailing:
      Text("$points", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
