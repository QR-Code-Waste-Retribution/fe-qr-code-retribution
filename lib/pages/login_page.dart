import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';
import 'package:qr_code_app/components/molekuls/input/input_group_custom.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Size device = const Size(0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    Future<void> login() async {
      _authProvider.isLoading.value = true;
      await _authProvider
          .login()
          .then((value) => {_authProvider.isLoading.value = false});
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            Text(
              'Sistem\nRetribusi\nSampah',
              style: primaryTextStyle.copyWith(
                fontSize: 36,
                fontWeight: semiBold,
              ),
            ),
            Image.asset(
              'assets/image/login_image.png',
              width: device.width * 0.35,
            ),
          ],
        ),
      );
    }

    Widget bodyInputLogin() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Text(
              'Login',
              style: secondaryTextStyle.copyWith(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "Silahkan login dengan username dan password yang terdaftar di sistem Retribusi Sampah Kabupaten Toba",
              style: primaryTextStyle.copyWith(
                letterSpacing: 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Obx(() {
          if (_authProvider.isLoading.value) {
            return const CustomLoading();
          }

          return Container(
            height: device.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              children: [
                header(),
                bodyInputLogin(),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => InputGroupCustom(
                    errorText: _authProvider.getErrorMessages['username'],
                    onChanged: (value) {
                      _authProvider.onChangeInputUsername();
                    },
                    hintText: "Username",
                    required: true,
                    inputController: _authProvider.usernameController.value,
                  ),
                ),
                Obx(
                  () => InputGroupCustom(
                    errorText: _authProvider.getErrorMessages['password'],
                    onChanged: (value) {
                      _authProvider.onChangeInputPassword();
                    },
                    obscure: true,
                    hintText: "Password",
                    required: true,
                    inputController: _authProvider.passwordController.value,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Pages.forgetPasswordPage);
                  },
                  child: Text(
                    'Lupa Password?',
                    style: priceTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                CustomButton(
                  title: 'Login',
                  width: 220,
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 80,
                  ),
                  onPressed: () {
                    login();
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
