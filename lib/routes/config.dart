part of './init.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(name: '/', page: () => const LoginPage()),
    GetPage(name: '/home', page: () => const HomePagination()),
    GetPage(name: '/invoice', page: () => const InvoicePeoplePage()),
    GetPage(name: '/scan_qr_code', page: () => const QRCodeScannerPage()),
    GetPage(name: '/generate_qr_code', page: () => const QRCodeGeneratorPage()),
  ];
}
