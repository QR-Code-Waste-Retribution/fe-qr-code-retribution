import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends GetSnackBar {
  const CustomSnackbar({super.key});

  Widget build(BuildContext context) {
    return const SnackBar(
      content: Text('This is a custom snackbar'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
  }
}
