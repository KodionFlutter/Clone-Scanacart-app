import 'package:flutter/material.dart';

class CustomSearchBarWidget extends StatelessWidget {
  final VoidCallback onChanged;
  final TextEditingController controller;

  const CustomSearchBarWidget(
      {super.key, required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: UnderlineInputBorder(),
        ),
        onChanged: (v) => onChanged,
      ),
    );
  }
}