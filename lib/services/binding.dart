import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories_provider.dart';
import 'package:qr_code_app/services/providers/invoice_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/services/providers/users_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/services/repositories/categories_repositories.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider(), fenix: true);
    Get.lazyPut<InvoiceProvider>(() => InvoiceProvider(), fenix: true);
    Get.lazyPut<TransactionProvider>(() => TransactionProvider(), fenix: true);
    Get.lazyPut<CategoriesProvider>(() => CategoriesProvider(), fenix: true);
    Get.lazyPut<UsersProvider>(() => UsersProvider(), fenix: true);

    Get.lazyPut<PaginationProvider>(() => PaginationProvider(), fenix: true);

    Get.lazyPut<AuthRepositories>(() => AuthRepositories(), fenix: true);
    Get.lazyPut<UserRepositories>(() => UserRepositories(), fenix: true);
    Get.lazyPut<InvoiceRepositories>(() => InvoiceRepositories(), fenix: true);
    Get.lazyPut<TransactionRepositories>(() => TransactionRepositories(), fenix: true);
    Get.lazyPut<CategoriesRepositories>(() => CategoriesRepositories(), fenix: true);
  }
}
