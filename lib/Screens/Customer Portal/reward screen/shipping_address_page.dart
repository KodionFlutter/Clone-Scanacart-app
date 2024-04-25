import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/authentication/widgets/common_TextField.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/controller/shipping_address_controller.dart';
import 'package:scan_cart_clone/Screens/Customer%20Portal/reward%20screen/widgets/common_appbar_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

import 'widgets/cart_counter_widget.dart';

class ShippingAddressPage extends StatelessWidget {
  ShippingAddressPage({super.key});

  final shippingController = Get.put(ShippingAddressController());

  @override
  Widget build(BuildContext context) {
    // return CommonAppbar(
    //   title: "Shipping Details",
    //   countItem: 10,
    //   body: Column(
    //     children: [
    //       //! Name .
    //
    //     ],
    //   ),
    //   bottomNavigationBar: ElevatedButton(
    //       onPressed: () {},
    //       style: ElevatedButton.styleFrom(
    //         elevation: 0,
    //         backgroundColor: Colors.blue,
    //         fixedSize:
    //             Size(AppConstant.size.width, AppConstant.size.height * 0.07),
    //       ),
    //       child: Text(
    //         "Place Order (${10} Points)",
    //         style: TextStyle(
    //           color: AppColors.txtWhiteColor,
    //           fontSize: 15,
    //           fontFamily: 'Montserrat',
    //           fontWeight: FontWeight.w600,
    //         ),
    //       )),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Shipping Address"),
        actions: [
          CartCounterWidget(
            itemCount: 10,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonTxtFieldWidget(
                    textEditController: shippingController.nameController.value,
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
                ),

                //! Email
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonTxtFieldWidget(
                    textEditController:
                        shippingController.emailController.value,
                    textInputType: TextInputType.emailAddress,
                    icons: Icons.mail,
                    hinText: 'Email',
                    preFixText: '',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!shippingController.regEmail.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                //! Phone Number ..

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonTxtFieldWidget(
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
                ),
                //! Address

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonTxtFieldWidget(
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
                ),
                //! City
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonTxtFieldWidget(
                    textEditController: shippingController.cityController.value,
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
                //! State
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                //! zip code
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommonTxtFieldWidget(
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
                ),
              ],
            ),
          ),
          //! For Save the Address
          CheckboxListTile(
            title: Text(
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
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
            if (shippingController.globalKey.currentState!.validate()) {}
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            fixedSize:
                Size(AppConstant.size.width, AppConstant.size.height * 0.07),
          ),
          child: Text(
            "Place Order (${10} Points)",
            style: TextStyle(
              color: AppColors.txtWhiteColor,
              fontSize: 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}