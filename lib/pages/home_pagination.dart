import 'package:flutter/material.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:get/get.dart';

class HomePagination extends StatefulWidget {
  const HomePagination({super.key});

  @override
  State<HomePagination> createState() => _HomePaginationState();
}

class _HomePaginationState extends State<HomePagination> {
  final AuthProvider authProvider = Get.find<AuthProvider>();
  final PaginationProvider paginationProvider = Get.find<PaginationProvider>();

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor6,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: paginationProvider.currentIndex.value,
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
        onTap: paginationProvider.updateCurrentIndex,
        items: paginationProvider
            .roleMenus[authProvider.authData.user?.role.name]!,
      ),
      body: Obx(
        () => Center(
          child: paginationProvider
              .rolePages[authProvider.authData.user?.role.name]!
              .elementAt(paginationProvider.currentIndex.value),
        ),
      ),
    );
  }
}
