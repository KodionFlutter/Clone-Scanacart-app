import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class ScanProductBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const ScanProductBtnWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(
            top: 20, left: 15, right: 15, bottom: 20),
        child: SizedBox(
            height: 49,
            width: double.infinity,
            child: ElevatedButton(
                onPressed:onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor:const  Color(0xFFC1E2FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Scan Product',
                  style: TextStyle(
                    color: AppColors.txtScanProductColor,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ))));
  }
}
