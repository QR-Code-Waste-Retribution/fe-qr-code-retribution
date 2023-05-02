import 'package:flutter/material.dart';

import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/pages/home/masyarakat/masyarakat_home.dart';
import 'package:qr_code_app/pages/home/pemungut/pemungut_home.dart';

class HomeBody extends StatelessWidget {

  const HomeBody({
    Key? key,
    required this.device,
    required this.authProvider,
  }) : super(key: key);

  final Size device;
  final AuthData authProvider;

  // @override
  // void dispose() {
  //   authProvider.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String? role = authProvider.user?.role.name;

    Map<String, Widget> homeBody = {
      'pemungut': PemungutHome(device: device),
      'masyarakat': MasyarakatHome(device: device),
    };

    return homeBody[role]!;
  }
}
