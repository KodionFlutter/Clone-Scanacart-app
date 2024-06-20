import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/widget/ready_to_scan_widget.dart';

class ReadyToScanPage extends StatelessWidget {
  const ReadyToScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        ReadyToScanWidget(),
      ],
    );
  }
}
