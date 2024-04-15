import 'package:flutter/material.dart';

class AlertDialogBoxWidget extends StatelessWidget {
  final String title;
  final String message;
  const AlertDialogBoxWidget({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
    );
  }
}
