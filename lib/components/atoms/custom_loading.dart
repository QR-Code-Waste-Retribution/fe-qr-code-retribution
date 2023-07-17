import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CustomLoading extends StatelessWidget {
  final Color loadingColor;
  final Color textColor;
  final String text;

  const CustomLoading({
    super.key,
    this.loadingColor = Colors.white,
    this.textColor = Colors.white,
    this.text = "Loading...",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: loadingColor,
          ),
          const SizedBox(height: 10.0),
          Text(
            text,
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              wordSpacing: 1.5,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
