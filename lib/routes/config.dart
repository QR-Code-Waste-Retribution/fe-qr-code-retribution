part of './init.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(name: '/', page: () => const LoginPage()),
    GetPage(name: '/home', page: () => const HomePagination()),
    GetPage(name: '/invoice', page: () => const InvoicePeoplePage()),
    GetPage(name: '/scan_qr_code', page: () => const QRCodeScannerPage()),
    GetPage(name: '/generate_qr_code', page: () => const QRCodeGeneratorPage()),
    GetPage(name: '/additional_retribution', page: () => const AdditionalRetributionPage()),
    GetPage(name: '/manage_user_page', page: () => const ManageUserPage()),
    GetPage(name: '/non_cash_payment', page: () => const NonCashPage()),
    GetPage(name: '/virtual_account_page', page: () => const VirtualAccountPage()),
    GetPage(name: '/printer_portable_page', page: () => const PrinterPortablePage()),
    GetPage(name: '/invoice_payments_details', page: () => const PaymentDetails()),
  ];
}
