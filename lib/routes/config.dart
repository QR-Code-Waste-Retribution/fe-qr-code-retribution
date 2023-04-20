part of './init.dart';


class Pages {
  static final List<GetPage> pages = [
    GetPage(name: '/home', page: () => const HomePagination()),
    GetPage(name: '/', page: () => const PrinterPortable()),
    GetPage(name: '/invoice', page: () => const InvoicePeoplePage()),
  ];
}

