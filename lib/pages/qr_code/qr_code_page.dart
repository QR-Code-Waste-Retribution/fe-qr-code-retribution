import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({Key? key}) : super(key: key);

  @override
  State<QRCodeGeneratorPage> createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              title: 'Unduh Gambar QR Code',
              width: 200,
              height: 40,
              fontSize: 14,
              defaultRadiusButton: 10,
              onPressed: () async {
                _authProvider.downloadQRCode();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            QrImageView(
              data: _authProvider.getUUID!,
              version: QrVersions.auto,
              size: 320,
              padding: const EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
