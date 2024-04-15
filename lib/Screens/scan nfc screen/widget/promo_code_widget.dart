import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/controller/scan_nfc_controller.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class PromoCodetxtFeildWidget extends StatelessWidget {
   PromoCodetxtFeildWidget({super.key});
  final textEditController = Get.put(ScanNFCController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: SizedBox(
          height: (AppConstant.size.height - 40) / 12,
          child: TextFormField(
            controller: textEditController.promoCodeController.value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Montserrat",
              color: AppColors.txtBlackColor,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius:const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 0.50, color: AppColors.greyBackgroundColor)),
                filled: true,
                hintStyle: const TextStyle(
                    fontFamily: "Montserrat", color: Color(0xFF75758B)),
                hintText: "Enter Product Code",
                fillColor: AppColors.txtWhiteColor),
            onChanged: (value){
              print("Promocode value :: ${textEditController.promoCodeController.value.text}");
            },
            validator: (value){
              if(textEditController.promoCodeController.value.text.isEmpty){
                // show the toast if TextEdit isEmpty..
                print("Empty we can show the Toast");
              }
            },
          ),
        ),
      ),
    );
  }
}
