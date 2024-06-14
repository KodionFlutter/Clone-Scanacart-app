import 'package:flutter/material.dart';

class AppColors {
  //! Here is for LinearGradient Colors ..

  static var linearGradientColor = const LinearGradient(
    colors: [Color(0xFF44AAFF), Color(0xFFBE6EFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //Verify button background Colors
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
      const Color(0xFFBE6EFF).withOpacity(0.1),
      const Color(0xFF44AAFF).withOpacity(0.1),
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
  static var txtBlackColor = const Color(0xFF010D49);
  static var txtScanProductColor = const Color(0xFFB672FF);
  static var txtErrorTxtColor = const Color(0xFFE2050B);

  static var greyWithOpacity = Colors.grey.withOpacity(0.9);
  static var orTxtColor = const Color(0xFFDDDDDD);
  static var blueColor = Colors.blue;

  static var backgroundColor = const Color(0xFFeef4fc);
  static var orangeColor = Colors.orangeAccent;
  static var greenColor = Colors.green;
  static var transparentColor = Colors.transparent;
}

//pak578