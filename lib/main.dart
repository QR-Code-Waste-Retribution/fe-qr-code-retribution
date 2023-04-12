import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();  
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: routeLogin,
      initialBinding: AppBindings(),
    );
  }
}
