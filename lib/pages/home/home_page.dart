import 'package:flutter/material.dart';
import 'package:qr_code_app/components/molekuls/home_menu_grid.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/pages/home/home_body.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthProvider authProvider = Get.find<AuthProvider>();
  Size device = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0, bottom: 50, left: 0, right: 0),
        children: [
          Container(
            width: device.width,
            height: device.height * 1.6,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    'assets/image/home_image.png',
                    width: device.width,
                    scale: 0.9,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: HomeContent(
                    device: device,
                    authData: authProvider.authData,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  HomeContent({
    Key? key,
    required this.device,
    required this.authData,
  }) : super(key: key);

  final Size device;
  final AuthData? authData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: device.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Header
          Text(
            'Halo ${authData?.user?.name}',
            style: primaryTextStyle.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          // Header Home
          Container(
            width: device.width * 0.95,
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/image/login_image.png',
                  width: device.width * 0.325,
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    '${AppConstants.headerHome[authData?.user?.role.name]}',
                    style: primaryTextStyle.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Home Menu Grid
          HomeMenuGrid(device: device, authProvider: authData!,),

          // Home Body
          HomeBody(device: device, authProvider: authData!,),
        ],
      ),
    );
  }
}
