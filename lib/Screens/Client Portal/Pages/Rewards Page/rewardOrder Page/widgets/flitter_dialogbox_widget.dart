import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/controller/reward_order_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_drop_down_widget.dart';

class FlitterDialogBoxWidget extends StatelessWidget {
  FlitterDialogBoxWidget({super.key});

  final controller = Get.put(RewardOrderController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! There Are title ..
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  title: "Reward Orders",
                  size: 12,
                  color: AppColors.blackBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),

            //! Date Range ..
            CommonTextWidget(
                title: "Select Date Type:",
                size: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.blackBackgroundColor),
            Obx(
              () => TextFormField(
                controller: controller.selectDateController.value,
                maxLines: 1,
                readOnly: true,
                // enabled: false,
                onTap: () async {
                  // await
                  DateTimeRange? time = await showDateRangePicker(
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      barrierColor: Colors.white,
                      initialDateRange: DateTimeRange(
                          start: DateTime(2024, 03, 01), end: DateTime.now()),
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                  controller.selectedStartDate.value = time!.start.toString();
                  controller.selectedEndDate.value = time.end.toString();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.date_range),
                  hintText:
                      "${controller.selectedStartDate.value} - ${controller.selectedEndDate.value}",
                  hintStyle: TextStyle(color: AppColors.blackColor),
                  fillColor: AppColors.blackColor,
                ),
              ),
            ),

            const SizedBox(height: 10),

            CommonTextWidget(
                title: "Select Status Type:",
                size: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.blackBackgroundColor),
            const SizedBox(height: 10),
            CommonDropDownWidget(
                dropDownValue: controller.dropDownValue.value,
                valueList: controller.dropDownList),

            //! Here the Buttons ...

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const Spacer(),
                  CommonButtonWidget(
                      onPressed: () {},
                      buttonTxt: "Apply",
                      btnHeight: 40,
                      btnWidth: 100,
                      txtColor: AppColors.whiteBackgroundColor,
                      colors: AppColors.blueColor,
                      isEnabled: true),
                  const SizedBox(width: 10),
                  CommonButtonWidget(
                      onPressed: () {},
                      buttonTxt: "Export",
                      btnHeight: 40,
                      btnWidth: 100,
                      txtColor: AppColors.whiteBackgroundColor,
                      colors: AppColors.blueColor,
                      isEnabled: true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}