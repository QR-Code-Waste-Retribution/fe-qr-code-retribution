import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/binding.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: routes,
      getPages: Pages.pages,
      initialRoute: routeLogin,
      initialBinding: AppBindings(),
    );
  }
}
