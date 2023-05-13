import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends GetxController {
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
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
        colorText: whiteColor,
        borderRadius: 5,
      );
    });

    socket.connect();
  }
}
