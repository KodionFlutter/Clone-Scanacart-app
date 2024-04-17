import 'package:flutter/material.dart';

class RedeemBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonTxt;
  final double btnHeight;
  final double btnWidth;
  final LinearGradient? linearGradient;
  final Color? colors;
  final Color txtColor;

  const RedeemBtnWidget(
      {super.key,
      required this.onPressed,
      required this.buttonTxt,
      required this.btnHeight,
      required this.btnWidth,
      this.linearGradient,
      this.colors,
      required this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
            color: colors,
            gradient: linearGradient,
            borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
            onPressed: onPressed,
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
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            )));
  }
}
