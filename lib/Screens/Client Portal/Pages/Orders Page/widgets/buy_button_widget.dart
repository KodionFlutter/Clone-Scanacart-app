import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';

class BuysButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const BuysButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            backgroundColor: Colors.yellow,
            elevation: 0,
            // backgroundColor: Colors.yellow.withOpacity(0.8),
            side: BorderSide(
              color: Colors.black,
              width: 1,
            )),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              Icons.sync,
              color: Colors.black,
            ),
            SizedBox(width: 5),
            // Text("Buy It Again" , style: TextStyle(),),
            CommonTextWidget(
                title: "Buy It Again", size: 14, color: Colors.black)
          ],
        ),
      ),
    );
  }
}