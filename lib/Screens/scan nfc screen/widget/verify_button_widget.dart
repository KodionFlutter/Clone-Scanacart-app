import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class VerifyButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const VerifyButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
        const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: SizedBox(
            height: 49,
            width: double.infinity,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: AppColors.verifyLinearGradientColor,
                ),
                child: ElevatedButton(
                    onPressed:onPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child:  Text(
                      'Verify',
                      style: TextStyle(
                        color: AppColors.txtWhiteColor,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )))),
      ),
    );
  }
}
