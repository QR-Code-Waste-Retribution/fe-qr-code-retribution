import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';


class SearchInputWidget extends StatelessWidget {
  final Function(String) onChange;

  SearchInputWidget({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor6,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 15),
      child: Center(
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextFormField(
                style: primaryTextStyle.copyWith(color: Colors.black),
                onChanged: (String str) => onChange(str),
                decoration: InputDecoration(
                  hintText: 'Cari nama, kategori, dll',
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
            ),
          ],
        ),
      ),
    );
  }
}