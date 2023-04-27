import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_app/pages/help/help_page.dart';
import 'package:qr_code_app/pages/history/history_payment_page.dart';
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
      const HistoryPaymentPage(),
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
