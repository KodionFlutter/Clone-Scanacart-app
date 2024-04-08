import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/scan%20nfc%20screen/scan_nfc_screen.dart';

class SplashController extends GetxController {
  //! Here we call the onInit method ..
  @override
  void onInit() {
    _startAnimation();
    super.onInit();
  }

  //! Start animation
  void _startAnimation() async {
    // Here the duration after going to next page
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(ScanNFCScreen());
    });
  }
}
