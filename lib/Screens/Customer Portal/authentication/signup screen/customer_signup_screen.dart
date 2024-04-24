import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signin%20screen/customer_login_page.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signup%20screen/controller/customer_signup_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_TextField.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_header_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

import '../otp verify screen/otp_verify_screen.dart';

class CustomerSignUpScreen extends StatelessWidget {
  CustomerSignUpScreen({super.key});

  final signUpController = Get.put(CustomerSignupController());

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
            children: [
              //! Show the Scanacart Text .
              CommonHeaderWidget(
                title: 'Sign Up to account',
                subtitle: 'Welcome back to Scanacart!',
                voidCallback: () {
                  signUpController.customerEmailController.value.clear();
                  signUpController.customerNameController.value.clear();
                  signUpController.customerPhoneController.value.clear();
                  Get.back();
                },
              ),
              //! Form Name section
              Form(
                  key: signUpController.formKey,
                  child: Column(
                    children: [
                      //! Name Field
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 10, left: 10, bottom: 10),
                        child: CommonTxtFieldWidget(
                          textEditController:
                              signUpController.customerNameController.value,
                          textInputType: TextInputType.text,
                          icons: Icons.person,
                          hinText: "Name",
                          preFixText: "",
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return FormValidator.txtName;
                            }
                            return null;
                          },
                        ),
                      ),
                      //! Email field
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CommonTxtFieldWidget(
                          textEditController:
                              signUpController.customerEmailController.value,
                          textInputType: TextInputType.emailAddress,
                          icons: Icons.email,
                          hinText: "Email",
                          preFixText: "",
                          validator: (val) {
                            // if (val!.isEmpty) {
                            //   return FormValidator.txtMail;
                            // } else if (!signUpController.reg.hasMatch(val)) {
                            //   return FormValidator.txtValidMail;
                            // }
                            return null;
                          },
                        ),
                      ),
                      //! Or
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFDDDDDD)),
                              ),
                            ),
                            Text(
                              'Or',
                              style: TextStyle(
                                color: AppColors.txtWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: AppColors.greyBackgroundColor)),
                            )
                          ],
                        ),
                      ),
                      //! Phone number Field
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CommonTxtFieldWidget(
                          textEditController:
                              signUpController.customerPhoneController.value,
                          textInputType: TextInputType.phone,
                          icons: Icons.phone,
                          maxLength: 10,
                          hinText: "Phone",
                          preFixText: "+1 ",
                          validator: (val) {
                            // if (val!.isEmpty) {
                            //   return FormValidator.txtPhoneNumber;
                            // } else if (val.length < 10) {
                            //   return FormValidator.txtValidPhoneNumber;
                            // }
                            return null;
                          },
                        ),
                      ),

                      //!SignUp button
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 30, right: 20, top: 20),
                        child: CommonButtonWidget(
                          isEnabled: true,
                          onPressed: () async {
                            log("${signUpController.customerPhoneController.value.text}");

                            if (signUpController
                                .customerNameController.value.text.isEmpty) {
                              showMessage(
                                  "Name field is required!\n${FormValidator.txtName}",
                                  AppColors.txtWhiteColor);
                            } else if (signUpController.customerEmailController
                                    .value.text.isEmpty &&
                                signUpController.customerPhoneController.value
                                    .text.isEmpty) {
                              showMessage("Required email or Phone number",
                                  Colors.white);
                              // print("object");
                            } else if ((signUpController.customerEmailController.value.text.isNotEmpty && !signUpController.reg.hasMatch(
                                signUpController
                                    .customerEmailController.value.text))){
                              showMessage(
                                  FormValidator.txtValidMail, Colors.white);
                            } else if((signUpController.customerPhoneController.value
                                .text.length >
                                0 &&
                                signUpController.customerPhoneController
                                    .value.text.length <
                                    10)){
                              showMessage(
                                  FormValidator.txtValidPhoneNumber, Colors.white);
                            }

                            // else if (signUpController.customerPhoneController
                            //             .value.text.length >
                            //         0 &&
                            //     signUpController.customerPhoneController.value
                            //             .text.length <
                            //         10) {
                            //   showMessage(FormValidator.txtValidPhoneNumber,
                            //       Colors.white);
                            // }

                            else {
                              await signUpController.signUPCustomer({
                                "name": signUpController
                                    .customerNameController.value.text,
                                "email": signUpController
                                    .customerEmailController.value.text,
                                "phone": signUpController
                                    .customerPhoneController.value.text,
                              });
                              // showMessage("Working", Colors.green);
                              signUpController.customerEmailController.value
                                  .clear();
                              signUpController.customerNameController.value
                                  .clear();
                              signUpController.customerPhoneController.value
                                  .clear();
                            }

                            Get.off(OtpVerifyScreen(
                              id: signUpController
                                  .customerSignUpModel.customerId!,
                            ));
                          },
                          buttonTxt: 'Sign Up',
                          btnHeight: AppConstant.size.height * 0.07,
                          btnWidth: AppConstant.size.width * 0.7,
                          colors: AppColors.whiteBackgroundColor,
                          txtColor: AppColors.blackColor,
                        ),
                      ),

                      //! login text
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Do you have an account yet? ",
                              style: TextStyle(
                                color: AppColors.txtWhiteColor,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                    text: "Login",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        signUpController
                                            .customerEmailController.value
                                            .clear();
                                        signUpController
                                            .customerNameController.value
                                            .clear();
                                        signUpController
                                            .customerPhoneController.value
                                            .clear();
                                        Get.off(CustomerLoginPage());
                                      }),
                              ],
                            ),
                          ),
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
