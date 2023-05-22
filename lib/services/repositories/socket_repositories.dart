import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketRepositories extends GetxService {
  IO.Socket? socket;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void connect({required Map<String, dynamic>? query}) {
    socket = IO.io(AppConstants.urlSocket, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': query!,
    });

    socket?.onConnect((_) {
      socket?.emit('join', {
        'name': 'Masyarakat',
      });
    });

    socket?.on('message', (data) {
      print('${data['user']}: ${data['text']}');

      Get.snackbar(
        "Success",
        '${data['user']}: ${data['text']}',
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
    });

    socket?.connect();

    socket!.on('connect', (_) {
      print('Connected to socket server');
    });

    // Handle other socket events and messages here
  }

  void disconnect() {
    socket?.disconnect();
    print('Disconnected from socket server');
  }
}
