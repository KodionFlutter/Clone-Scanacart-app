import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderDetailsAddressWidget extends StatelessWidget {
  final int orderId;
  final String date;
  final String address;
  final String name;
  final String city;
  final String email;
  final String zipCode;
  final String status;
  final VoidCallback onTap;
  final bool isFielded;

  const OrderDetailsAddressWidget(
      {super.key,
        required this.orderId,
        required this.date,
        required this.address,
        required this.name,
        required this.city,
        required this.email,
        required this.zipCode,
        required this.status,
        required this.onTap,
        required this.isFielded});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(15),
      width: AppConstant.size.width * 1,
      // height: AppConstant.size.height*1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppColors.orderPage,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Order Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Order No: $orderId",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Text(
                "$status".toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: status == "Pending"
                        ? Colors.yellow.shade700
                        : AppColors.txtErrorTxtColor),
              ),
            ],
          ),
          SizedBox(height: 8),
          //! date of booking order .
          Text("$date"),
          SizedBox(height: 8),
          Text("Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text("$name"),
          Text("$address"),
          Text("$city, $zipCode"),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("$email")),
              InkWell(
                onTap: onTap,
                child: Text("View Notes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue..shade400)),
              ),
              SizedBox(width: 5),
              isFielded == true
                  ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              )
                  : SizedBox(),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}