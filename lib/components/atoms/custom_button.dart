import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function()? onPressed;
  final EdgeInsets margin;
  final Color backgroundColor;
  final double height;
  final double fontSize;
  final double defaultRadiusButton;

  const CustomButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 55,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = primaryColor,
    this.fontSize = 18,
    this.defaultRadiusButton = defaultRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadiusButton),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: fontSize,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
