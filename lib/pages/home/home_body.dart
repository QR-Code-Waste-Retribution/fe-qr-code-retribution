import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/pages/home/masyarakat/masyarakat_home.dart';
import 'package:qr_code_app/pages/home/pemungut/pemungut_home.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';

class HomeBody extends StatelessWidget {
  final AuthProvider authProvider = Get.find<AuthProvider>();

  HomeBody({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Size device;

  @override
  Widget build(BuildContext context) {
    String? role = authProvider.userRole;

    Map<String, Widget> homeBody = {
      'pemungut': PemungutHome(device: device),
      'masyarakat': MasyarakatHome(device: device),
    };

    return homeBody[role]!;
  }
}
