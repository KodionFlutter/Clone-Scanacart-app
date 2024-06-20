import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/auth/controller/client_login_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/auth/forgot_password.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_TextField.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_header_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class ClientLoginPage extends StatelessWidget {
  ClientLoginPage({super.key});

  final clientLoginController = Get.put(ClientLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppConstant.size.height,
        width: AppConstant.size.width,
        decoration: BoxDecoration(
          gradient: AppColors.linearGradientColor,
        ),
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              CommonHeaderWidget(
                title: 'Client Portal',
                subtitle: 'Welcome back to Scanacart!',
                voidCallback: () {
                  Get.back();
                  clientLoginController.isLoading.value = false;
                  clientLoginController.emailController.value.clear();
                  clientLoginController.passwordController.value.clear();
                },
              ),
              const SizedBox(height: 25),
              //!
              Form(
                  key: clientLoginController.globalFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonTxtFieldWidget(
                          obscureText: false,
                          textEditController:
                              clientLoginController.emailController.value,
                          icons: Icons.email,
                          textInputType: TextInputType.emailAddress,
                          hinText: "Email",
                          preFixText: "",
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return FormValidator.txtMail;
                            } else if (!clientLoginController.reg
                                .hasMatch(val!)) {
                              return FormValidator.txtValidMail;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonTxtFieldWidget(
                          textEditController:
                              clientLoginController.passwordController.value,
                          obscureText: true,
                          icons: Icons.lock_outline,
                          textInputType: TextInputType.visiblePassword,
                          hinText: "Password",
                          preFixText: "",
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return FormValidator.txtPassword;
                            }
                            return null;
                          },
                        ),
                      ),

                      //! Login Button ...
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(
                              left: 30, bottom: 30, right: 30, top: 20),
                          child: clientLoginController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CommonButtonWidget(
                                  isEnabled:
                                      clientLoginController.isEnable.value,
                                  onPressed: () async {
                                    // print("Working");
                                    if (clientLoginController
                                        .globalFormKey.currentState!
                                        .validate()) {
                                      //! call the client login method ..
                                      var map = {
                                        "email": clientLoginController
                                            .emailController.value.text
                                            .toString(),
                                        "password": clientLoginController
                                            .passwordController.value.text
                                            .toString()
                                      };

                                      clientLoginController.clientLogin(map);
                                    }
                                  },
                                  buttonTxt: 'Login',
                                  btnHeight: AppConstant.size.height * 0.06,
                                  btnWidth: AppConstant.size.width * 0.7,
                                  colors: AppColors.whiteBackgroundColor,
                                  txtColor: AppColors.blackColor,
                                ),
                        ),
                      ),

                      //! Forgot Password ...
                      InkWell(
                        onTap: () {
                          Get.to(const ForgotPassword());
                          clientLoginController.emailController.value.clear();
                          clientLoginController.passwordController.value
                              .clear();
                        },
                        child: Text(
                          "Forgot password ?",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.txtWhiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
