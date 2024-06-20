import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/validator_form.dart';
import 'package:scan_cart_clone/Common/widgets/common_button.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signin%20screen/controller/customer_signin_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/signup%20screen/customer_signup_screen.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_TextField.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_header_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CustomerLoginPage extends StatelessWidget {
  CustomerLoginPage({super.key});

  final customerLoginController = Get.put(CustomerAuthController());

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
              //! Show the Scanacart Text .
              CommonHeaderWidget(
                title: 'Customer Portal',
                subtitle: 'Welcome back to Scanacart!',
                voidCallback: () {
                  customerLoginController.customerPhoneNumberController.value
                      .clear();
                  customerLoginController.customerEmailController.value.clear();
                  Get.back();
                },
              ),

              // Email Text Field
              Obx(
                () => Form(
                    key: customerLoginController.formKey,
                    child: Column(
                      children: [
                        //! Email field section
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CommonTxtFieldWidget(
                            textEditController: customerLoginController
                                .customerEmailController.value,
                            icons: Icons.email,
                            textInputType: TextInputType.emailAddress,
                            hinText: "Email",
                            obscureText: false,
                            preFixText: "",
                            validator: (val) {
                              // var reg = RegExp(FormValidator.emailReg);
                              // if (val.toString().isEmpty) {
                              //   return FormValidator.txtMail;
                              // } else if (!customerLoginController.reg
                              //     .hasMatch(val!)) {
                              //   return FormValidator.txtValidMail;
                              // } else {
                              //   return null;
                              // }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
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
                        //! Phone Number Field section
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, right: 10, bottom: 10),
                          child: CommonTxtFieldWidget(
                            textEditController: customerLoginController
                                .customerPhoneNumberController.value,
                            icons: Icons.phone,
                            maxLength: 10,
                            obscureText: false,
                            textInputType: TextInputType.phone,
                            hinText: "Phone",
                            preFixText: "+1 ",
                            validator: (val) {
                              // if (val.toString().isEmpty) {
                              //   return FormValidator.txtPhoneNumber;
                              // } else if (val!.length < 10) {
                              //   return FormValidator.txtValidPhoneNumber;
                              // } else {
                              //   return null;
                              // }
                              return null;
                            },
                          ),
                        ),

                        //! Login Button ..
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, bottom: 30, right: 30, top: 20),
                          child: CommonButtonWidget(
                            isEnabled: customerLoginController.isEnable.value,
                            onPressed: () async {
                              //shi@yopmail.com

                              if (customerLoginController
                                      .customerEmailController
                                      .value
                                      .text
                                      .isEmpty &&
                                  customerLoginController
                                      .customerPhoneNumberController
                                      .value
                                      .text
                                      .isEmpty) {
                                //! Show the message .
                                showMessage(
                                    "Please enter email or phone number",
                                    Colors.white);
                              } else if ((customerLoginController
                                      .customerEmailController
                                      .value
                                      .text
                                      .isNotEmpty &&
                                  !customerLoginController.reg.hasMatch(
                                      customerLoginController
                                          .customerEmailController
                                          .value
                                          .text))) {
                                showMessage(
                                    FormValidator.txtValidMail, Colors.white);
                              } else if ((customerLoginController
                                          .customerPhoneNumberController
                                          .value
                                          .text.isNotEmpty &&
                                  customerLoginController
                                          .customerPhoneNumberController
                                          .value
                                          .text
                                          .length <
                                      10)) {
                                showMessage(FormValidator.txtValidPhoneNumber,
                                    Colors.white);
                              } else {
                                await customerLoginController.customerLogin(
                                  customerLoginController
                                      .customerEmailController.value.text,
                                  customerLoginController
                                      .customerPhoneNumberController.value.text,
                                );
                              }
                              // else {
                              //   if (!customerLoginController.reg.hasMatch(
                              //       customerLoginController
                              //           .customerEmailController.value.text)) {
                              //     showMessage(
                              //         "Please enter valid email", Colors.white);
                              //     // print("Not matcjed");
                              //   } else if (customerLoginController
                              //               .customerPhoneNumberController
                              //               .value
                              //               .text
                              //               .length <
                              //           10 &&
                              //       customerLoginController
                              //               .customerPhoneNumberController
                              //               .value
                              //               .text
                              //               .length >
                              //           0) {
                              //     showMessage("Please enter valid number",
                              //         Colors.white);
                              //     // print("matched");
                              //   } else {
                              //     await customerLoginController.customerLogin(
                              //       customerLoginController
                              //           .customerEmailController.value.text,
                              //       customerLoginController
                              //           .customerPhoneNumberController
                              //           .value
                              //           .text,
                              //     );
                              //   }
                              // }
                            },
                            buttonTxt: 'Login',
                            btnHeight: AppConstant.size.height * 0.06,
                            btnWidth: AppConstant.size.width * 0.7,
                            colors: AppColors.whiteBackgroundColor,
                            txtColor: AppColors.blackColor,
                          ),
                        ),
                        //! text
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Or connect using",
                        //       style: TextStyle(
                        //         color: AppColors.txtWhiteColor,
                        //         fontSize: 14,
                        //         fontFamily: 'Montserrat',
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        //! Social Media Icons.
                        const SizedBox(height: 10),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Container(
                        //       height: AppConstant.size.height * 0.06,
                        //       width: AppConstant.size.width * 0.4,
                        //       decoration: BoxDecoration(
                        //           color: Colors.blue,
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           SizedBox(width: 20),
                        //           Image(
                        //             image: AssetImage(
                        //               "assets/images/google.png",
                        //             ),
                        //             height: 20,
                        //             width: 20,
                        //           ),
                        //           SizedBox(width: 5),
                        //           Expanded(
                        //               child: Text(
                        //             "Google",
                        //             style: TextStyle(
                        //                 color: AppColors.txtWhiteColor),
                        //           ))
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       height: AppConstant.size.height * 0.06,
                        //       width: AppConstant.size.width * 0.4,
                        //       decoration: BoxDecoration(
                        //           color: Colors.blue[800],
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Row(
                        //         children: [
                        //           SizedBox(width: 20),
                        //           Image(
                        //             image: AssetImage(
                        //               "assets/images/facebook.png",
                        //             ),
                        //             height: 20,
                        //             width: 20,
                        //           ),
                        //           SizedBox(width: 5),
                        //           Expanded(
                        //               child: Text(
                        //             "Facebook",
                        //             style: TextStyle(
                        //                 color: AppColors.txtWhiteColor),
                        //           ))
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // Signup text
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "Haven't account? ",
                                style: TextStyle(
                                  color: AppColors.txtWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                      text: "Sign Up",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          customerLoginController
                                              .customerPhoneNumberController
                                              .value
                                              .clear();
                                          customerLoginController
                                              .customerEmailController.value
                                              .clear();
                                          Get.off(CustomerSignUpScreen());
                                        }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
