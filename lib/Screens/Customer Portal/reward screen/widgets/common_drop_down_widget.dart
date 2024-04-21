import 'package:flutter/material.dart';

class CommonDropDownWidget extends StatefulWidget {
  String dropdownvalue;
  final List valueList;

  CommonDropDownWidget(
      {super.key, required this.dropdownvalue, required this.valueList});

  @override
  State<CommonDropDownWidget> createState() => _CommonDropDownWidgetState();
}

class _CommonDropDownWidgetState extends State<CommonDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(

        decoration: const InputDecoration(
            enabled: true,
            filled: true,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
        // isExpanded: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        isDense: true,
        validator: (value) {},
        value: widget.dropdownvalue.isEmpty
            ? null
            : widget.dropdownvalue.toString(),
        items: [
          ...widget.valueList.map((element) {
            return DropdownMenuItem(
                enabled: true, value: element, child: Text(element.toString()));
          }),
        ],
        onChanged: (newValue) {
          widget.dropdownvalue = newValue.toString();
        });
  }
}
