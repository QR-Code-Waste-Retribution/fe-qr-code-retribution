part of './init.dart';

class Pages {
  static const String loginPage = '/';
  static const String homePage = '/home';
  static const String recapitulationPage = '/recapitulation';
  static const String invoicePage = '/invoice';
  static const String scanQRCodePage = '/scan_qr_code';
  static const String generateQRCodePage = '/generate_qr_code';
  static const String additionalRetributionPage = '/additional_retribution';
  static const String manageUserPage = '/manage_user_page';
  static const String nonCashPaymentPage = '/non_cash_payment';
  static const String virtualAccountListPage = '/virtual_account_page';
  static const String printerPortablePage = '/printer_portable_page';
  static const String invoicePaymentsDetailsPage = '/invoice_payments_details';
  static const String addUserPage = '/add_user';
  static const String editUserPage = '/edit_user';
  static const String historyPaymentPemungutPage = '/history_payment_pemungut';
  static const String changePasswordPage = '/change_password';
  static const String editProfilePage = '/edit_profile';
  static const String forgetPasswordPage = '/forget_password';
  static const String listCategoriesPage = '/list_categories';
  static const String virtualAccountPayPage = '/virtual_account_pay_page';

  static final List<GetPage> pages = [
    GetPage(name: loginPage, page: () => const LoginPage()),
    GetPage(name: homePage, page: () => const HomePagination()),
    GetPage(name: recapitulationPage, page: () => const RecapitulationPage()),
    GetPage(name: invoicePage, page: () => const InvoicePeoplePage()),
    GetPage(name: scanQRCodePage, page: () => const QRCodeScannerPage()),
    GetPage(name: generateQRCodePage, page: () => const QRCodeGeneratorPage()),
    GetPage(name: additionalRetributionPage, page: () => const AdditionalRetributionPage()),
    GetPage(name: manageUserPage, page: () => const ManageUserPage()),
    GetPage(name: nonCashPaymentPage, page: () => const NonCashPage()),
    GetPage(name: virtualAccountListPage, page: () => const VirtualAccountListPage()),
    GetPage(name: printerPortablePage, page: () => const PrinterPortablePage()),
    GetPage(name: invoicePaymentsDetailsPage, page: () => const PaymentDetails()),
    GetPage(name: addUserPage, page: () => const AddUserPage()),
    GetPage(name: editUserPage, page: () => const EditUserPage()),
    GetPage(name: historyPaymentPemungutPage, page: () => const HistoryPaymentPemungutPage()),
    GetPage(name: changePasswordPage, page: () => const ChangePasswordPage()),
    GetPage(name: editProfilePage, page: () => const EditProfilePage()),
    GetPage(name: forgetPasswordPage, page: () => const ForgetPasswordPage()),
    GetPage(name: listCategoriesPage, page: () => const ListCategoriesPage()),
    GetPage(name: virtualAccountPayPage, page: () => const VirtualAccountPayPage()),
  ];
}
