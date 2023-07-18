import 'package:flutter/material.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:get/get.dart';

class HomePagination extends StatelessWidget {
  HomePagination({super.key});

  final AuthProvider authProvider = Get.find<AuthProvider>();
  final PaginationProvider paginationProvider = Get.put(PaginationProvider(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
              .roleMenus[authProvider.authData.user?.role?.name]!,
        ),
        body: Center(
          child: paginationProvider
              .rolePages[authProvider.authData.user?.role?.name]!
              .elementAt(paginationProvider.currentIndex.value),
        ),
      ),
    );
  }
}
