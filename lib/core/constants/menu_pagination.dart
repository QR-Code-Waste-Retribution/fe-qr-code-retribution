import 'package:flutter/material.dart';

import 'package:qr_code_app/pages/help/help_page.dart';
import 'package:qr_code_app/pages/home/home_page.dart';
import 'package:qr_code_app/pages/qr_code/qr_code_scanner_page.dart';
import 'package:qr_code_app/pages/qr_code/qr_code_page.dart';

class MenuPagination {
  static const Map<String, List<Widget>> rolePages = {
    'pemungut': [
      HomePage(),
      HelpPage(),
      QRCodeScannerPage(),
      Icon(
        Icons.chat,
        size: 150,
      ),
      QRCodeGeneratorPage(),
    ],
    'masyarakat': [
      HomePage(),
      Icon(
        Icons.help,
        size: 150,
      ),
      Icon(
        Icons.payment,
        size: 150,
      ),
      Icon(
        Icons.chat,
        size: 150,
      ),
      QRCodeGeneratorPage(),
    ],
  };

  static const Map<String, List<BottomNavigationBarItem>> roleMenus = {
    'pemungut': [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.perm_contact_calendar,
        ),
        label: 'Kelola Akun',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.payment,
        ),
        label: 'Tagih',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.assignment,
        ),
        label: 'Rekapitulasi',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: 'Profile',
      ),
    ],
    'masyarakat': [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.help,
        ),
        label: 'Bantuan',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.attach_money,
        ),
        label: 'Bayar',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.alarm,
        ),
        label: 'History',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: 'Profile',
      ),
    ],
  };
}
