import 'package:flutter/material.dart';

class ClientLoginWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ClientLoginWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset('assets/images/login.png', width: 24, height: 24),
    );
  }
}
