import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthProvider>(AuthProvider());
    
    Get.lazyPut<PaginationProvider>(() => PaginationProvider());
  }
}
