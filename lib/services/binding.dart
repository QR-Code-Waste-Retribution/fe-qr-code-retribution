import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth/change_password_provider.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories/categories_provider.dart';
import 'package:qr_code_app/services/providers/transaction/doku_provider.dart';
import 'package:qr_code_app/services/providers/auth/forgot_password_provider.dart';
import 'package:qr_code_app/services/providers/geographic_provider.dart';
import 'package:qr_code_app/services/providers/transaction/invoice_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/add_user_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/edit_user_provider.dart';
import 'package:qr_code_app/services/providers/auth/otp_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/pemungut_transaction_provider.dart';
import 'package:qr_code_app/services/providers/printer/printer_provider.dart';
import 'package:qr_code_app/services/providers/socket/socket_provider.dart';
import 'package:qr_code_app/services/providers/transaction/transaction_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/users_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/services/repositories/categories_repositories.dart';
import 'package:qr_code_app/services/repositories/doku_repositories.dart';
import 'package:qr_code_app/services/repositories/geographic_provider.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/services/repositories/pemungut_transaction_repositories.dart';
import 'package:qr_code_app/services/repositories/socket_repositories.dart';
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
    Get.lazyPut<PemungutTransactionProvider>(
        () => PemungutTransactionProvider(),
        fenix: true);
    Get.lazyPut<DokuProvider>(() => DokuProvider(), fenix: true);
    Get.lazyPut<SocketProvider>(() => SocketProvider(), fenix: true);
    Get.lazyPut<GeographicProvider>(() => GeographicProvider(), fenix: true);
    Get.lazyPut<PrinterProvider>(() => PrinterProvider(), fenix: true);
    Get.lazyPut<ForgotPasswordProvider>(() => ForgotPasswordProvider(),
        fenix: true);
    Get.lazyPut<OtpProvider>(() => OtpProvider(), fenix: true);
    Get.lazyPut<EditUserProvider>(() => EditUserProvider(), fenix: true);
    Get.lazyPut<ChangePasswordProvider>(() => ChangePasswordProvider(),
        fenix: true);
    Get.lazyPut<AddUserProvider>(() => AddUserProvider(), fenix: true);

    // Pagination
    Get.put<PaginationProvider>(PaginationProvider());

    Get.lazyPut<AuthRepositories>(() => AuthRepositories(), fenix: true);
    Get.lazyPut<UserRepositories>(() => UserRepositories(), fenix: true);
    Get.lazyPut<InvoiceRepositories>(() => InvoiceRepositories(), fenix: true);
    Get.lazyPut<TransactionRepositories>(() => TransactionRepositories(),
        fenix: true);
    Get.lazyPut<CategoriesRepositories>(() => CategoriesRepositories(),
        fenix: true);
    Get.lazyPut<PemungutTransactionRepositories>(
        () => PemungutTransactionRepositories(),
        fenix: true);
    Get.lazyPut<DokuRepositories>(() => DokuRepositories(), fenix: true);
    Get.lazyPut<SocketRepositories>(() => SocketRepositories(), fenix: true);
    Get.lazyPut<GeographicRepositories>(() => GeographicRepositories(),
        fenix: true);
  }
}
