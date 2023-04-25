import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/invoice_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthProvider>(AuthProvider());
    Get.put<InvoiceProvider>(InvoiceProvider());
    Get.put<TransactionProvider>(TransactionProvider());

    Get.lazyPut<PaginationProvider>(() => PaginationProvider());

    Get.put<AuthRepositories>(AuthRepositories());
    Get.put<InvoiceRepositories>(InvoiceRepositories());
    Get.put<TransactionRepositories>(TransactionRepositories());
  }
}
