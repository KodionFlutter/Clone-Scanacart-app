import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/scan_nfc_screen.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Orders"),
          actions: [Icon(Icons.more_vert), SizedBox(width: 10)],
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,
            Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,  Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
            ) ,  Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,  Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,  Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,  Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,  Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: AppConstant.size.width,
              decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(10)),
            ) ,
          ],
        ));
  }
}
