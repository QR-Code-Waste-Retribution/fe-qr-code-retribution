import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Image.asset('assets/image/home_image.png'),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Text(
                'Halo Petugas A',
                style: primaryTextStyle.copyWith(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
