import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/core/constants/storage.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends GetxController {
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  late IO.Socket socket;

  RxBool vaStatus = false.obs;

  bool get getVAStatus => vaStatus.value;

  final Map<String, String> typeOfSocketChannel = {
    'default': 'join',
    'va': 'payment_va',
  };

  void initSocketIO({required String? uuid, required String typeOfChannel}) {
    socket = IO.io(AppConstants.urlSocketServer, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'uuid': uuid, 'role': _authProvider.userRole},
    });

    socket.onConnect((_) {
      socket.emit('payment_va', {
        'name': _authProvider.userName,
      });
    });

    if (typeOfChannel == 'va') {
      socket.on('va_status', (data) {
        vaStatus.value = data['status'];
        if (vaStatus.value) {
          StorageReferences().removeStorageReferencesDokuPayment();

          Get.snackbar(
            "Success",
            "Berhasil melakukan pembayaran",
            backgroundColor: primaryColor,
            colorText: Colors.white,
            borderRadius: 5,
          );

          Get.toNamed(Pages.homePage);
        }
      });
    }

    socket.on('message', (data) {
      Get.snackbar(
        "Success",
        "",
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
    });

    // Connect to the server
    socket.connect();
  }
}
