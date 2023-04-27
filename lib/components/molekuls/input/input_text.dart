import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InputText extends StatelessWidget {
  final String hintText;
  const InputText({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor6,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 15),
      child: TextFormField(
        style: primaryTextStyle.copyWith(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: subtitleTextStyle.copyWith(fontSize: 15),
          contentPadding: const EdgeInsets.only(top: 15.0),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.clear,
              size: 20,
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
