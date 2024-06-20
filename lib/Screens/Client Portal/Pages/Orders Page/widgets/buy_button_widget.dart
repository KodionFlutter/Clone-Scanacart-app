import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';

class BuysButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const BuysButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 125,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(-1, -1),
          blurRadius: 3,
        ),
        BoxShadow(
          color: Colors.black12,
          offset: Offset(1, 1),
          blurRadius: 3,
        )
      ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.yellow,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const Icon(
              Icons.sync,
              color: Colors.black,
            ),
            const SizedBox(width: 5),
            // Text("Buy It Again" , style: TextStyle(),),
            CommonTextWidget(
                title: "Buy It Again", size: 14, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
