import 'package:flutter/material.dart';

class VirtualAccount {
  final String name;
  final String typeVA;
  final String fullName;
  final Widget icon;

  const VirtualAccount(
      {required this.name, required this.icon, required this.typeVA, required this.fullName });
}
