import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Models/admin_login_model.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientHome%20Page/client_home_page.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientLoginController extends GetxController {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var reg = RegExp(FormValidator.emailReg);
  RxBool isEnable = true.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  AdminLoginModel adminLoginModel = AdminLoginModel();
  RxString adminEmail = "".obs;
  RxString adminClientLogo = "".obs;
  RxString adminClientName = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //! Make a loginMethod ...

  Future clientLogin(Map<String, dynamic> map) async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      adminLoginModel = await APIServices.hitClientLogin(map);
      print("Admin Token :: ${adminLoginModel.token}");
      var token = adminLoginModel.token;
      if (adminLoginModel.success == true) {
        prefs.setString("admin_email", adminLoginModel.email.toString());
        prefs.setString("admin_token", token!);
        prefs.setString(
            "admin_client_name", adminLoginModel.clientName.toString());
        prefs.setString(
            "admin_client_logo", adminLoginModel.clientLogo.toString());
        prefs.setInt("client_id", adminLoginModel.clientId!);
        isLoading.value = false;
        Get.to(ClientHomePage());
      } else {
        isLoading.value = false;
        showMessage(
            "${adminLoginModel.message}", AppColors.whiteBackgroundColor);
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
