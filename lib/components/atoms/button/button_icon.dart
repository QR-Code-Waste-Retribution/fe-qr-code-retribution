import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ButtonIcon extends StatelessWidget {
  final Function()? onPressed;
  final Color backgroundColor;
  final IconData icon;

  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double fontSize;
  final double defaultRadiusButton;

  const ButtonIcon({
    super.key,
    this.width,
    this.height,
    this.icon = Icons.add,
    this.margin,
    this.backgroundColor = Colors.black,
    this.defaultRadiusButton = 10,
    required this.onPressed,
    this.fontSize = 14,
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadiusButton),
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
