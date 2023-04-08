import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({super.key});

  @override
  State<QRCodeGeneratorPage> createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: primaryColor,
          ),
          onPressed: (() {
            setState(() {
              Navigator.pop(context);
            });
          }),
        ),
        title: Text(
          "Pembayaran Tunai",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: primaryColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: redColor,
              ),
              child: Text(
                'Silahkan Scan Barcode anda untuk melakukan pembayaran tunai',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            QrImage(
              data: "95d08e5b-8f28-3ff1-af78-be1fdf6588d8",
              version: QrVersions.auto,
              size: 320,
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
