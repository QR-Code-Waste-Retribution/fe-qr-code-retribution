import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/button/button_icon.dart';
import 'package:qr_code_app/components/molekuls/input/input_group_custom.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class SearchInputCustom extends StatelessWidget {
  final Function(String) onChange;
  final Function() onSearch;
  final TextEditingController? controller;
  final String hintText;

  const SearchInputCustom({
    super.key,
    required this.onChange,
    required this.onSearch,
    this.controller,
    this.hintText = "Search",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputGroupCustom(
            label: false,
            hintText: hintText,
            inputController: controller!,
            height: 45,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ButtonIcon(
          onPressed: () {
            onSearch();
          },
          height: 45,
          icon: Icons.search,
          backgroundColor: Colors.black45,
        ),
      ],
    );
  }
}
