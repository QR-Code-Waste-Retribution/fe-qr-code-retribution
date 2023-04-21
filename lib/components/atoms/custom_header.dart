import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CustomHeader extends StatelessWidget {
  final String text;

  const CustomHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: primaryTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
