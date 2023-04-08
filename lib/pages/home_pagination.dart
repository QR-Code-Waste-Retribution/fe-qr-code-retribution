import 'package:flutter/material.dart';
import 'package:qr_code_app/core/constants/menu_pagination.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:get/get.dart';

class HomePagination extends StatefulWidget {
  const HomePagination({super.key});

  @override
  State<HomePagination> createState() => _HomePaginationState();
}

class _HomePaginationState extends State<HomePagination> {
  final AuthProvider authProvider = Get.find<AuthProvider>();

  int _selectedIndex = 0;

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    String? role = authProvider.userRole;

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
        items: MenuPagination.roleMenus[role]!,
      ),
      body: Center(
        child: MenuPagination.rolePages[role]!.elementAt(_selectedIndex),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
