import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LabelValidationLocationWidget extends StatelessWidget {
  LabelValidationLocationWidget({super.key});

  final labelValidationController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            title: "Label Validations Location",
            size: 14,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
          Divider(
              thickness: 1,
              color: AppColors.blackBackgroundColor.withOpacity(0.3)),

          //! Here is Char ..
          SizedBox(
              height: 250,
              child: Obx(
                () => labelValidationController.isLabelLocationLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SfMaps(
                        layers: <MapShapeLayer>[
                          MapShapeLayer(
                            source: labelValidationController.mapSource!,
                            showDataLabels: true,
                            tooltipSettings: const MapTooltipSettings(
                                color: Colors.black,
                                strokeColor: Colors.white,
                                strokeWidth: 1),
                            strokeColor: Colors.black,
                            strokeWidth: 0.5,
                            shapeTooltipBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 70,
                                width: labelValidationController
                                            .labelValidationData[index]
                                            .percentage !=
                                        0.0
                                    ? AppConstant.size.width * 0.4
                                    : AppConstant.size.width * 0.5,
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            labelValidationController
                                                .labelValidationData[index].city
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.white,
                                          endIndent: 4,
                                          indent: 2,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Validation : ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: CommonTextWidget(
                                                title:
                                                    '${labelValidationController.labelValidationData[index].percentage != 0.0 ? labelValidationController.labelValidationData[index].percentage : "undefined"} %',
                                                size: 14,
                                                color: AppColors
                                                    .whiteBackgroundColor,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            },
                            dataLabelSettings: const MapDataLabelSettings(
                              overflowMode: MapLabelOverflow.hide,
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 0),
                            ),
                          ),
                        ],
                      ),
              )),
        ],
      ),
    );
  }
}
