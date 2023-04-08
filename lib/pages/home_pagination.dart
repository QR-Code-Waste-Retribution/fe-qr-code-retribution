import 'package:flutter/material.dart';
import 'package:qr_code_app/pages/help/help_page.dart';
import 'package:qr_code_app/pages/home/home_page.dart';
import 'package:qr_code_app/pages/qr_code/qr_code_scanner_page.dart';
import 'package:qr_code_app/pages/qr_code/qr_code_page.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HomePagination extends StatefulWidget {
  const HomePagination({super.key});

  @override
  State<HomePagination> createState() => _HomePaginationState();
}

class _HomePaginationState extends State<HomePagination> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    HelpPage(),
    QRCodeScannerPage(),
    Icon(
      Icons.chat,
      size: 150,
    ),
    QRCodeGeneratorPage(),
  ];

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: backgroundColor6,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        selectedFontSize: 10,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          color: primaryColor,
          fontSize: 10,
        ),
        showUnselectedLabels: true,
        unselectedItemColor: navigationButtonColor,
        elevation: 0,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
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
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
