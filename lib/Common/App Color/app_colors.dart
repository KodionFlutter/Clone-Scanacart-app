import 'package:flutter/material.dart';

class AppColors {
  //! Here is for LinearGradient Colors ..

  static var linearGradientColor = const LinearGradient(
    colors: [Color(0xFF44AAFF), Color(0xFFBE6EFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //Varify button background Colors
  static var verifyLinearGradientColor = const LinearGradient(
    colors: [
      Color(0xFFBE6EFF),
      Color(0xFF44AAFF),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static var orderPage = LinearGradient(
    colors: [
      Color(0xFFBE6EFF).withOpacity(0.1),
      Color(0xFF44AAFF).withOpacity(0.1),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  // Here is use for background color
  static var whiteBackgroundColor = Colors.white;
  static var blackBackgroundColor = const Color(0xFF010D49);
  static var greyBackgroundColor = const Color(0xFFDDDDDD);
  static var blackColor = Colors.black;

  //! Colors for text Colors
  static var txtWhiteColor = Colors.white;
  static var txtBlackColor = Color(0xFF010D49);
  static var txtScanProductColor = Color(0xFFB672FF);
  static var txtErrorTxtColor = Color(0xFFE2050B);

  static var greyWithOpacity = Colors.grey.withOpacity(0.9);
  static var orTxtColor = Color(0xFFDDDDDD);
}

//pak578
