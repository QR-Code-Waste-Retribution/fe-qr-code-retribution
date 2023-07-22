import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/molekuls/arrow_option_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  @override
  void initState() {
    super.initState();
  }

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
          Container(
            color: whiteColor,
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/edit_profile');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Edit Profil',
                        style: whiteTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${_authProvider.authData.user?.name}',
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.settings_phone),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${_authProvider.authData.user?.phoneNumber}',
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.fact_check),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '1212394053374739',
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: device.width * 0.6,
                          child: Text(
                            '${_authProvider.authData.user?.address}',
                            style: primaryTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomHeader(text: 'Pengaturan'),
          const SizedBox(
            height: 7,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/change_password');
            },
            child: ArrowOptionCard(
              text: 'Ganti Kata Sandi',
              textColor: secondaryColor,
              iconsLeading: Icon(
                Icons.settings,
                color: secondaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          GestureDetector(
            onTap: () {
              logout();
            },
            child: const ArrowOptionCard(
              text: 'Logout',
              textColor: Colors.red,
              iconsLeading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
