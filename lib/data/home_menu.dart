import 'package:flutter/material.dart';

class HomeMenu {
  String iconText;
  IconData iconImage;
  String href;
  Function()? onClick;

  HomeMenu(
      {required this.iconText,
      required this.iconImage,
      required this.href,
      required this.onClick});
}

