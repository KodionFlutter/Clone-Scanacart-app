import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/Oder/widget/order_details_dialogbox_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class OrderDetailsAddressWidget extends StatelessWidget {
  const OrderDetailsAddressWidget({super.key});

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
                  "Order No: 155",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Text(
                "Pending".toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.yellow.shade700),
              ),
            ],
          ),
          SizedBox(height: 8),
          //! date of booking order .
          Text("24 Apr 2024"),
          SizedBox(height: 8),
          Text("Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text("Name"),
          Text("address"),
          Text("city, pincode"),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("email address")),
              InkWell(
                onTap: (){
                  showDialog(context: context, builder: (_){
                   return OrderDetailsDialogBoxWidget();
                  });
                },
                child: Text("View Notes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue..shade400)),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
