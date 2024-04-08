import 'package:flutter/cupertino.dart';

//! Declare for accessing the context.
GlobalKey<NavigatorState> navigatorKey =  GlobalKey();

class AppConstant{
  static var size = MediaQuery.of(navigatorKey.currentState!.context).size;
}