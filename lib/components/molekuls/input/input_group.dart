import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import './input_text.dart';

class InputGroup extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final String subLabel;
  const InputGroup({
    super.key,
    required this.hintText,
    this.obscure = false,
    this.subLabel = '',
  });

  @override
  Widget build(BuildContext context) {
    Widget subLabelCreate() {
      if (subLabel.isNotEmpty) {
        return Text(
          subLabel,
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: blackColor,
            fontStyle: FontStyle.italic,
          ),
        );
      }
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          subLabelCreate(),
          const SizedBox(
            height: 10,
          ),
          InputText(
            hintText: hintText,
            obscure: obscure,
          ),
        ],
      ),
    );
  }
}
