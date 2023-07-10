import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class OptionTile extends StatefulWidget {
  final String label;
  final String subLabel;
  final bool selected;
  final void Function()? onTap;

  const OptionTile(
      {super.key,
      required this.label,
      required this.subLabel,
      this.selected = false,
      required this.onTap});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: widget.selected ? Colors.black26 : Colors.white,
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.print_rounded,
              color: widget.selected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: primaryTextStyle.copyWith(
                    color: widget.selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  widget.subLabel,
                  style: primaryTextStyle.copyWith(
                    color: widget.selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
