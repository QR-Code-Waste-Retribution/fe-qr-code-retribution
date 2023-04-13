import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Size device = const Size(0, 0);

  Future<void> logout() async {
    _authProvider.isLoading.value = true;
    await _authProvider
        .logout()
        .then((value) => {_authProvider.isLoading.value = false});
  }

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () {
              logout();
            },
            child: Container(
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
                  const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Keluar",
                      style: blackTextStyle.copyWith(
                        color: redColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.05,
                      ),
                    ),
                  ),
                  const Icon(Icons.navigate_next),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
