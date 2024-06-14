import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: 1,
      onSelected: (value) {
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: "All",
          child: Text("All"),
        ),
        PopupMenuItem(
          value: "Pending",
          child: Text("Pending"),
        ),
        PopupMenuItem(
          value: "Cancel",
          child: Text("Cancel"),
        ),
        PopupMenuItem(
          value: "Fulfilled",
          child: Text("Fulfilled"),
        ),
      ],
      offset: const Offset(10, 10),
      shadowColor: Colors.black,
      elevation: 2,
    );
  }
}