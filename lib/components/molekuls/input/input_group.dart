import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import './input_text.dart';

class InputGroup extends StatefulWidget {
  final String hintText;
  final bool obscure;
  final String subLabel;
  final bool required;
  final TextEditingController inputController;
  final TextInputType keyboardType;

  const InputGroup({
    super.key,
    required this.hintText,
    this.obscure = false,
    this.required = false,
    required this.inputController,
    this.keyboardType = TextInputType.text,
    this.subLabel = '',
  });

  @override
  State<InputGroup> createState() => _InputGroupState();
}

class _InputGroupState extends State<InputGroup> {
  bool inputNullCheck = false;

  @override
  Widget build(BuildContext context) {
    Widget subLabelCreate() {
      if (widget.subLabel.isNotEmpty) {
        return Text(
          widget.subLabel,
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
            "${widget.hintText} ${widget.required ? '*' : ''}",
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
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor6,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: inputNullCheck ? redColor : transparent,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: widget.keyboardType,
                      controller: widget.inputController,
                      obscureText: widget.obscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a value";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        if (widget.required) {
                          if (value.isEmpty) {
                            inputNullCheck = true;
                          } else {
                            inputNullCheck = false;
                            // The user has entered something.
                          }
                        }
                        setState(() {});
                      },
                      scrollPadding: const EdgeInsets.only(bottom: 40),
                      style: primaryTextStyle.copyWith(color: Colors.black),
                      decoration: InputDecoration.collapsed(
                        hintText: widget.hintText,
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          textInvalidInput(),
        ],
      ),
    );
  }

  Widget textInvalidInput() {
    return inputNullCheck
        ? Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                "Input ${widget.hintText.toLowerCase()} tidak boleh kosong",
                style: primaryTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: redColor,
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
