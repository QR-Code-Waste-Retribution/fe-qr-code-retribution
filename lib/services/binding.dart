import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories_provider.dart';
import 'package:qr_code_app/services/providers/invoice_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/services/repositories/categories_repositories.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<InvoiceProvider>(() => InvoiceProvider());
    Get.lazyPut<TransactionProvider>(() => TransactionProvider());
    Get.lazyPut<CategoriesProvider>(() => CategoriesProvider());

    Get.lazyPut<PaginationProvider>(() => PaginationProvider());

    Get.lazyPut<AuthRepositories>(() => AuthRepositories());
    Get.lazyPut<InvoiceRepositories>(() => InvoiceRepositories());
    Get.lazyPut<TransactionRepositories>(() => TransactionRepositories());
    Get.lazyPut<CategoriesRepositories>(() => CategoriesRepositories());
  }
}
