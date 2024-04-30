import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_TextField.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/shipping_address_controller.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/cart_counter_widget.dart';

class ShippingAddressPage extends StatelessWidget {
  final num totalPoints;
  final int clientId;

  ShippingAddressPage(
      {super.key, required this.totalPoints, required this.clientId});

  final shippingController = Get.put(ShippingAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Shipping Address"),
          actions: [
            CartCounterWidget(
              clientId: 0,
              clientName: '',
            )
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: shippingController.globalKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CommonTxtFieldWidget(
                      textEditController:
                          shippingController.nameController.value,
                      textInputType: TextInputType.name,
                      icons: Icons.person,
                      hinText: 'Full Name',
                      preFixText: '',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        } else if (shippingController.reg.hasMatch(value)) {
                          return "Please enter a valid name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    //! Email
                    CommonTxtFieldWidget(
                      textEditController:
                          shippingController.emailController.value,
                      textInputType: TextInputType.emailAddress,
                      icons: Icons.mail,
                      hinText: 'Email',
                      preFixText: '',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        } else if (!shippingController.regEmail
                            .hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    //! Phone Number ..

                    CommonTxtFieldWidget(
                      textEditController:
                          shippingController.phoneNumberController.value,
                      textInputType: TextInputType.phone,
                      icons: Icons.phone,
                      hinText: 'Phone Number',
                      preFixText: '',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone Number";
                        } else if (value.length < 10) {
                          return "Please enter a valid phone Number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    //! Address

                    CommonTxtFieldWidget(
                      textEditController:
                          shippingController.addressController.value,
                      textInputType: TextInputType.streetAddress,
                      icons: Icons.place_rounded,
                      hinText: 'Address',
                      preFixText: '',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    //! City

                    Row(
                      children: [
                        Expanded(
                          child: CommonTxtFieldWidget(
                            textEditController:
                                shippingController.cityController.value,
                            textInputType: TextInputType.text,
                            icons: Icons.location_city,
                            hinText: 'City',
                            preFixText: '',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your city";
                              }
                              return null;
                            },
                          ),
                        ),
                      const   SizedBox(width: 10),
                        //! State
                        Expanded(
                          child: CommonTxtFieldWidget(
                            textEditController:
                                shippingController.stateController.value,
                            textInputType: TextInputType.text,
                            icons: Icons.location_city,
                            hinText: 'State',
                            preFixText: '',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your state";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    //! zip code
                    CommonTxtFieldWidget(
                      textEditController:
                          shippingController.zipCodeController.value,
                      textInputType: TextInputType.number,
                      icons: Icons.numbers,
                      hinText: 'Zip Code',
                      preFixText: '',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your zip Code";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            //! For Save the Address
            CheckboxListTile(
              title: const Text(
                "Save this address for next order",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: true,
              onChanged: (newValue) {},
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => ElevatedButton(
              onPressed: shippingController.message.value.isNotEmpty
                  ? () {}
                  : () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      int? customerId = preferences.getInt('customer_id');

                      if (shippingController.globalKey.currentState!
                          .validate()) {
                        shippingController.productShipping({
                          'name': shippingController.nameController.value.text,
                          'email':
                              shippingController.emailController.value.text,
                          'phone': shippingController
                              .phoneNumberController.value.text,
                          'address':
                              shippingController.addressController.value.text,
                          'city': shippingController.cityController.value.text,
                          'state':
                              shippingController.stateController.value.text,
                          'zipcode':
                              shippingController.zipCodeController.value.text,
                          'customer_id': (customerId ?? '0').toString(),
                          'total_points': (totalPoints).toString(),
                          'client_id': (clientId ?? '0').toString(),
                          'cart_Items': shippingController.cartItemsJson,
                          'save_address':
                              shippingController.select == true ? '1' : '0',
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: shippingController.message.value.isNotEmpty
                    ? Colors.red
                    : Colors.blue,
                fixedSize: Size(
                    AppConstant.size.width, AppConstant.size.height * 0.07),
              ),
              child: Obx(
                () => Text(
                  shippingController.message.value.isNotEmpty
                      ? shippingController.message.value.toString()
                      : "Place Order ($totalPoints Points)",
                  style: TextStyle(
                    color: AppColors.txtWhiteColor,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
        ));
  }
}
