import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/services/api_client.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Size device = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    @override
    void initState() {
      emailController.dispose();
      passwordController.dispose();
      super.initState();
    }

    void login() async {
      Client client = Client();
      AuthProvider authProvider = AuthProvider(client.init());
      ResponseAPI authResponse = await authProvider.login(
        username: emailController.text,
        password: passwordController.text,
      );
      if (authResponse.success) {
        AuthData data = AuthData.fromJson(authResponse.data);
        var snackBar = SnackBar(content: Text(authResponse.message));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushNamed(context, '/home');
        }
      } else {
        var snackBar = SnackBar(
          content: Text(authResponse.message),
          backgroundColor: alertColor,
        );
        if (context.mounted)
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
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
        margin: EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Text(
              'Login',
              style: secondaryTextStyle.copyWith(
                fontSize: 30,
              ),
            ),
            SizedBox(
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

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username / NIK',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor6,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        scrollPadding: EdgeInsets.only(bottom: 40),
                        style: primaryTextStyle.copyWith(color: Colors.black),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Username / NIK',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Container passwordInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor6,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        scrollPadding: EdgeInsets.only(bottom: 40),
                        obscureText: true,
                        style: primaryTextStyle.copyWith(color: Colors.black),
                        decoration: InputDecoration.collapsed(
                          fillColor: backgroundInputColor,
                          hintText: 'Password',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              header(),
              bodyInputLogin(),
              emailInput(),
              passwordInput(),
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
        ),
      ),
    );
  }
}
