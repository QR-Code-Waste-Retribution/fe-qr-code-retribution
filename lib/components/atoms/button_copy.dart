import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ButtonCopy extends StatelessWidget {
  final String textToCopy;

  const ButtonCopy({super.key, required this.textToCopy});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    Get.snackbar(
      "Success",
      'Sukses salin nomor virtual account',
      backgroundColor: primaryColor,
      colorText: Colors.white,
      borderRadius: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _copyToClipboard(context);
      },
      icon: const Icon(
        Icons.copy,
        size: 16,
      ),
    );
  }
}
