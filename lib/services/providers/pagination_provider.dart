import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/data/home_menu.dart';

import 'package:qr_code_app/pages/help/help_page.dart';
import 'package:qr_code_app/pages/history/masyarakat/history_payment_masyarakat_page.dart';
import 'package:qr_code_app/pages/home/home_page.dart';
import 'package:qr_code_app/pages/manage_user/manage_user_page.dart';
import 'package:qr_code_app/pages/payment/payment_method_page.dart';
import 'package:qr_code_app/pages/profile/profile_page.dart';
import 'package:qr_code_app/pages/recapitulation/recapitulation_page.dart';

class PaginationProvider extends GetxController {
  RxInt currentIndex = 0.obs;

  int get getCurrentIndex => currentIndex.value;

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  late Map<String, List<HomeMenu>> listHomeMenu;

  RxMap<String, List<Widget>> rolePages = {
    'pemungut': [
      const HomePage(),
      const ManageUserPage(),
      const PaymentMethod(),
      const RecapitulationPage(),
      const ProfilePage(),
    ],
    'masyarakat': [
      const HomePage(),
      const HelpPage(),
      const PaymentMethod(),
      const HistoryPaymentMasyarakatPage(),
      const ProfilePage(),
    ],
  }.obs;

  RxMap<String, List<BottomNavigationBarItem>> roleMenus = {
    'pemungut': [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.perm_contact_calendar,
        ),
        label: 'Kelola Akun',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.payment,
        ),
        label: 'Tagih',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.assignment,
        ),
        label: 'Rekapitulasi',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: 'Profile',
      ),
    ],
    'masyarakat': [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.help,
        ),
        label: 'Bantuan',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.attach_money,
        ),
        label: 'Bayar',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.alarm,
        ),
        label: 'History',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: 'Profile',
      ),
    ],
  }.obs;

  @override
  void onInit() {
    super.onInit();

    listHomeMenu = {
      'pemungut': [
        HomeMenu(
            iconText: 'Riwayat Pembayaran',
            iconImage: Icons.list,
            href: '/history_payment_pemungut',
            onClick: () {
              Get.toNamed('/history_payment_pemungut');
            }),
        HomeMenu(
            iconText: 'Tagih',
            iconImage: Icons.money,
            href: '/',
            onClick: () {
              updateCurrentIndex(2);
            }),
        HomeMenu(
            iconText: 'Rekapitulasi',
            iconImage: Icons.assignment,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(3);
            }),
        HomeMenu(
            iconText: 'Tambah Akun',
            iconImage: Icons.person_add,
            href: '/history_payment_pemungut',
            onClick: () {
              Get.toNamed('/add_user');
            }),
        HomeMenu(
            iconText: 'Akun Masyarakat',
            iconImage: Icons.people_sharp,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(1);
            }),
        HomeMenu(
            iconText: 'Profile',
            iconImage: Icons.person,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(4);
            }),
      ],
      'masyarakat': [
        HomeMenu(
            iconText: 'Bantuan',
            iconImage: Icons.help,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(1);
            }),
        HomeMenu(
            iconText: 'Bayar',
            iconImage: Icons.payment,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(2);
            }),
        HomeMenu(
            iconText: 'History',
            iconImage: Icons.history,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(3);
            }),
        HomeMenu(
            iconText: 'Daftar Kategori',
            iconImage: Icons.menu_book,
            href: '/list_categories',
            onClick: () {
              Get.toNamed('/list_categories');
            }),
        HomeMenu(
            iconText: 'Profile',
            iconImage: Icons.person,
            href: '/history_payment_pemungut',
            onClick: () {
              updateCurrentIndex(4);
            }),
      ],
    }.obs;
  }

  @override
  void onClose() {
    // Inisialisasi ulang controller setelah onDelete
    Get.lazyPut(() => PaginationProvider());
    super.onClose();
  }

  @override
  InternalFinalCallback<void> get onDelete => super.onDelete;
}
