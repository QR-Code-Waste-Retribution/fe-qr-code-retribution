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
    Get.put<AuthProvider>(AuthProvider());
    Get.put<InvoiceProvider>(InvoiceProvider());
    Get.put<TransactionProvider>(TransactionProvider());
    Get.put<CategoriesProvider>(CategoriesProvider());
    Get.put<UsersProvider>(UsersProvider());

    Get.lazyPut<PaginationProvider>(() => PaginationProvider());

    Get.put<AuthRepositories>(AuthRepositories());
    Get.put<UserRepositories>(UserRepositories());
    Get.put<InvoiceRepositories>(InvoiceRepositories());
    Get.put<TransactionRepositories>(TransactionRepositories());
    Get.put<CategoriesRepositories>(CategoriesRepositories());
  }
}
