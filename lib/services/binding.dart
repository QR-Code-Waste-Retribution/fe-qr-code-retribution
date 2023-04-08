import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    
  }
}
