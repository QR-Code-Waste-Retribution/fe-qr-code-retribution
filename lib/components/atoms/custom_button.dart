import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = primaryColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
