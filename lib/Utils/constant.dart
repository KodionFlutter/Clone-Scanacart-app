import 'package:flutter/cupertino.dart';

//! Declare for accessing the context.
GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class AppConstant {
  static var size = MediaQuery.of(navigatorKey.currentState!.context).size;

  static String nfcText =
      "Reader is located along the top\nmiddle, or bottom of the backside of your phone";
  static String nfcEnableText = "Please enable NFC in settings";

}
