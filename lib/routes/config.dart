

part of './init.dart';

var routes = {
  routeLogin: (context) => const LoginPage(),
  routeHome: (context) => const HomePagination(),
};


class Pages {
  static final List<GetPage> pages = [
    GetPage(name: '/home', page: () => HomePagination()),
    GetPage(name: '/', page: () => LoginPage()),
  ];
}

