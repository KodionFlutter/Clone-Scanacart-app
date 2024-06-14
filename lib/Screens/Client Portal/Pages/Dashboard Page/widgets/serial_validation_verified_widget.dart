import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Models/serial_validation_model.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SerialValidationVerified extends StatelessWidget {
  SerialValidationVerified({super.key});

  final serialValidationController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return CustomContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
                title: "Serial Validations Verified",
                size: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor),
            Divider(
                thickness: 1,
                color: AppColors.blackBackgroundColor.withOpacity(0.3)),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Text(
                "Total Verified : ${serialValidationController.totalVerified.value}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //! Here is Char ..
            Container(
              padding: const EdgeInsets.all(10.0),
              height: AppConstant.size.height * 0.25,
              width: AppConstant.size.width * 1,
              // decoration: BoxDecoration(color: Colors.red),
              child: Obx(
                () => serialValidationController.isVerifiedLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SfCartesianChart(
                        tooltipBehavior:
                            serialValidationController.tooltipBehavior.value,
                        primaryXAxis: const CategoryAxis(),
                        primaryYAxis: const NumericAxis(labelFormat: '{value}'),
                        series: [
                          LineSeries<SerialValidationModel, String>(
                            dataSource: serialValidationController.cartData
                                as List<SerialValidationModel>,
                            xValueMapper:
                                (SerialValidationModel serialModel, _) =>
                                    serialModel.label,
                            yValueMapper:
                                (SerialValidationModel serialModel, _) =>
                                    serialModel.values,
                            enableTooltip: true,
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
      );
    });
  }
}
