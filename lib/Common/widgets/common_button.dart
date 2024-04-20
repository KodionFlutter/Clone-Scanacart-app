import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class CommonButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonTxt;
  final double btnHeight;
  final double btnWidth;
  final LinearGradient? linearGradient;
  final Color? colors;
  final Color txtColor;
  final bool isEnabled;

  const CommonButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonTxt,
    required this.btnHeight,
    required this.btnWidth,
    this.linearGradient,
    this.colors,
    required this.txtColor,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
            color: isEnabled ? colors : Colors.transparent,
            // Use disabledColor when isEnabled is false
            gradient: isEnabled ? linearGradient : null,
            borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
            onPressed: isEnabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonTxt,
              style: TextStyle(
                color: txtColor,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            )));
  }
}
