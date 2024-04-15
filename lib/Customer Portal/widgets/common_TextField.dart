import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';

class CommonTxtFieldWidget extends StatelessWidget {
  final TextEditingController textEditController;
  final TextInputType textInputType;
  final IconData icons;
  final String hinText;
  final String? preFixText;
  final String? Function(String?)? validator;

  CommonTxtFieldWidget({
    super.key,
    required this.textEditController,
    required this.textInputType,
    required this.icons,
    required this.hinText,
    this.preFixText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.black,
      ),
      controller: textEditController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      validator:  validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hinText,
        hintStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
            fontSize: 16),
        errorStyle: TextStyle(
            color: AppColors.txtErrorTxtColor,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            fontSize: 12),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
        prefix: Text(
          "$preFixText",
          style: TextStyle(
            color: AppColors.blackColor,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        prefixIcon: Icon(
          icons,
          color: Colors.black,
        ),
      ),
    );
  }
}
