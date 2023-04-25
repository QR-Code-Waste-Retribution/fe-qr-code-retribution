import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: whiteColor,
          ),
          const SizedBox(height: 10.0),
          Text(
            'Loading...',
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              wordSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
