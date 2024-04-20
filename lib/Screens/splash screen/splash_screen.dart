import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/splash%20screen/controller/splash_controller.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // Expand stack to cover entire screen
      fit: StackFit.expand ,
      children: [
        Image.asset('assets/splash/splash_image.png',
            // This is for background image
            fit: BoxFit.cover),
        Center(
          child: Image.asset(
              'assets/splash/img_splash_anim.gif', // This is gif image
              width: AppConstant.size.height*0.5,
              height: AppConstant.size.width*0.5),
        )
      ],
    ));
  }
}
