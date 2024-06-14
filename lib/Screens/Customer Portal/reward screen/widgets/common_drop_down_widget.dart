import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonDropDownWidget extends StatefulWidget {
  String dropDownValue;
  List valueList;

  CommonDropDownWidget(
      {super.key, required this.dropDownValue, required this.valueList});

  @override
  State<CommonDropDownWidget> createState() => _CommonDropDownWidgetState();
}

class _CommonDropDownWidgetState extends State<CommonDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
            enabled: true,
            hintText: "Select Address",
            // filled: true,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
        // isExpanded: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        isDense: true,
        value: widget.dropDownValue.isEmpty
            ? null
            : widget.dropDownValue.toString(),
        items: [
          ...widget.valueList.map((element) {
            return DropdownMenuItem(
                enabled: true, value: element, child: Text(element.toString()));
          }),
        ],
        onChanged: (newValue) {
          setState(() {
            widget.dropDownValue = newValue.toString();
          });
          if (kDebugMode) {
            print("Value is :: ${widget.dropDownValue}");
          }
        });
  }
}
