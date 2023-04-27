import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ArrowOptionCard extends StatefulWidget {
  final String text;
  final Widget iconsLeading;
  final Color textColor;
  const ArrowOptionCard(
      {super.key,
      required this.text,
      required this.iconsLeading,
      this.textColor = Colors.black});

  @override
  State<ArrowOptionCard> createState() => _ArrowOptionCardState();
}

class _ArrowOptionCardState extends State<ArrowOptionCard> {
  Size device = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Container(
      width: device.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          widget.iconsLeading,
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.text,
              style: blackTextStyle.copyWith(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.05,
              ),
            ),
          ),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
