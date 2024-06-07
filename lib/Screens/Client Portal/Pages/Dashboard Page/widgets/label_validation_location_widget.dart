import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/controller/dashboard_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
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
          const Text("Label Validations Location"),
          Divider(
              thickness: 1,
              color: AppColors.blackBackgroundColor.withOpacity(0.3)),

          //! Here is Char ..
          SizedBox(
            height: 250,
            child: SfMaps(
              layers: <MapShapeLayer>[
                MapShapeLayer(
                  source: labelValidationController.mapSource,
                  showDataLabels: true,
                  tooltipSettings: const MapTooltipSettings(
                      color: Colors.black,
                      strokeColor: Colors.white,
                      strokeWidth: 1),
                  strokeColor: Colors.black,
                  strokeWidth: 0.5,
                  shapeTooltipBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 70,
                      width: labelValidationController
                                  .labelValidationData[index].dout !=
                              0.0
                          ? 140
                          : 190,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                labelValidationController
                                    .labelValidationData[index].state
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.white,
                                endIndent: 4,
                                indent: 2,
                              ),
                              Text(
                                "Validation : ${labelValidationController.labelValidationData[index].dout != 0.0 ? labelValidationController.labelValidationData[index].dout : "undefined"} %",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
          ),
        ],
      ),
    );
  }
}