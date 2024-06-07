import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Models/serial_validation_model.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LabelValidationWidget extends StatelessWidget {
  LabelValidationWidget({super.key});

  final labelValidationController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Label Validations",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        //! Tabs..
        Row(
          children: [
            Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          labelValidationController.isSelected.value
                              ? Colors.blue
                              : Colors.transparent,
                      elevation: 0,
                      side: BorderSide(
                        width:
                            labelValidationController.isSelected.value ? 0 : 1,
                        color: labelValidationController.isSelected.value
                            ? AppColors.transparentColor
                            : AppColors.blackColor,
                      )),
                  onPressed: () {
                    labelValidationController.isSelected.value = true;
                    labelValidationController.getSerialValidationData(
                        "7",
                        labelValidationController.sevenDaysModel
                            as RxList<SerialValidationModel>);
                  },
                  child: Text(
                    "Last 7 Days",
                    style: TextStyle(
                        color: labelValidationController.isSelected.value
                            ? Colors.white
                            : Colors.black),
                  ),
                )),
            const SizedBox(width: 10),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: labelValidationController.isSelected.value
                        ? Colors.transparent
                        : Colors.blue,
                    elevation: 0,
                    side: BorderSide(
                      width: labelValidationController.isSelected.value ? 1 : 0,
                      color: labelValidationController.isSelected.value
                          ? AppColors.blackColor
                          : AppColors.transparentColor,
                    )),
                onPressed: () {
                  labelValidationController.isSelected.value = false;
                  labelValidationController.thirtyDaysModel
                      .addAll(labelValidationController.thirtyDays);
                  labelValidationController.getSerialValidationData(
                      "30",
                      labelValidationController.thirtyDaysModel
                          as RxList<SerialValidationModel>);
                },
                child: Text(
                  "Last 30 Days",
                  style: TextStyle(
                      color: labelValidationController.isSelected.value
                          ? Colors.black
                          : Colors.white),
                ),
              ),
            )
          ],
        ),

        Container(
            padding: const EdgeInsets.all(10.0),
            height: AppConstant.size.height * 0.3,
            width: AppConstant.size.width * 1,
            // decoration: BoxDecoration(color: Colors.red),
            child: Obx(() => SfCartesianChart(
                  tooltipBehavior:
                      labelValidationController.tooltipBehavior.value,
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: const NumericAxis(labelFormat: '{value}'),
                  series: [
                    ColumnSeries<SerialValidationModel, String>(
                      dataSource: labelValidationController.cartData
                          as List<SerialValidationModel>,
                      xValueMapper: (SerialValidationModel serialModel, _) =>
                          serialModel.months,
                      yValueMapper: (SerialValidationModel serialModel, _) =>
                          serialModel.values,
                      enableTooltip: true,
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                  ],
                )))
      ],
    ));
  }
}