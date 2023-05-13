import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({super.key});

  @override
  State<QRCodeGeneratorPage> createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocketIO();
  }

  void initSocketIO() {
    socket = IO.io('http://localhost:6001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'uuid': _authProvider.authData.user?.uuid},
    });
    socket.onConnect((_) {
      socket.emit('join', {
        'name': 'Masyarakat',
      });
    });

    socket.on('message', (data) {
      print('${data['user']}: ${data['text']}');

      Get.snackbar(
        "Success",
        '${data['user']}: ${data['text']}',
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
    });

    socket.connect();
  }

  void _sendMessage() {
    // Emit a 'message' event to the server
    socket.emit('message', {'user': 'Zico', 'text': 'has Joined!!'});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
          onPressed: (() {
            Get.back();
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
            GestureDetector(
              onTap: () => _sendMessage(),
              child: QrImage(
                data: _authProvider.getUUID!,
                version: QrVersions.auto,
                size: 320,
                padding: const EdgeInsets.all(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
