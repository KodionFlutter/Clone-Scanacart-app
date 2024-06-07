import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Models/serial_validation_model.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SerialValidationVerified extends StatelessWidget {
  SerialValidationVerified({super.key});

  final serialValidationController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Serial Validations Verified"),
          Divider(
              thickness: 1,
              color: AppColors.blackBackgroundColor.withOpacity(0.3)),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Text(
              "Total Verified : 28,922",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //! Here is Char ..
          Container(
            padding: EdgeInsets.all(10.0),
            height: AppConstant.size.height * 0.3,
            width: AppConstant.size.width * 1,
            // decoration: BoxDecoration(color: Colors.red),
            child: SfCartesianChart(
              tooltipBehavior: serialValidationController.tooltipBehavior.value,
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(labelFormat: '{value}'),
              series: [
                LineSeries<SerialValidationModel, String>(
                  dataSource: serialValidationController.cartData
                      as List<SerialValidationModel>,
                  xValueMapper: (SerialValidationModel serialModel, _) =>
                      serialModel.months,
                  yValueMapper: (SerialValidationModel serialModel, _) =>
                      serialModel.values,
                  enableTooltip: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}