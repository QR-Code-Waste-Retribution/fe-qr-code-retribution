import 'dart:io';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/transaction/invoice_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final InvoiceProvider _invoiceProvider = Get.find<InvoiceProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Barcode? result;
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
  }

  void initSocketIO({required String uuid}) {
    socket = IO.io(AppConstants.urlSocketServer, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'uuid': uuid, 'role': _authProvider.authData.user?.role?.name},
    });

    socket.onConnect((_) {
      socket.emit('join', {
        'name': 'Pemungut',
      });
    });

    socket.on('message', (data) {
      Get.snackbar(
        "Success",
        '${data['user']}: ${data['text']}',
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
    });

    // Connect to the server
    socket.connect();
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    socket.disconnect();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  Future<void> scanQrCode(String? uuid) async {
    await qrViewController!.pauseCamera();
    initSocketIO(uuid: uuid!);
    _invoiceProvider.getInvoiceUserByUUIDandSubDistrict(
      uuid: uuid,
      subDistrictId: _authProvider.authData.user?.subDistrictId,
      pemungutId: _authProvider.getUserId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            setState(() {
              Get.back();
            });
          }),
        ),
        title: Text(
          "Scan QR Code",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  child: CustomButton(
                    onPressed: () async {
                      await qrViewController?.resumeCamera();
                    },
                    title: 'Scan QR Code',
                    width: 200,
                    height: 40,
                    defaultRadiusButton: 7,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrViewController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        scanQrCode(result?.code);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
