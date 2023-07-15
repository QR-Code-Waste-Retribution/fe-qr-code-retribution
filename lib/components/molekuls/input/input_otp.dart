import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InputOTP extends StatelessWidget {
  final Widget textField;
  const InputOTP({Key? key, required this.textField}) : super(key: key);
  factory InputOTP.primary(
      {Function(String value)? onSubmitted,
      Function(String value)? onChanged,
      TextEditingController? controller}) {
    return InputOTP(textField: Builder(builder: (context) {
      return Pinput(
        length: 6,
        controller: controller,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        defaultPinTheme: PinTheme(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              stops: [0.08, 0.08],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black26,
                Colors.white,
              ],
            ),
          ),
          height: 50,
          width: 80,
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        submittedPinTheme: PinTheme(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                stops: [0.08, 0.08],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [primaryColor, Colors.white]),
          ),
          height: 50,
          width: 80,
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return textField;
  }
}
