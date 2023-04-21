import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class RecapitulationPage extends StatefulWidget {
  const RecapitulationPage({super.key});

  @override
  State<RecapitulationPage> createState() => _RecapitulationPageState();
}

class _RecapitulationPageState extends State<RecapitulationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Riwayat Tagihan",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        children: [Text('Rekapitulasi Page')],
      ),
    );
  }
}
