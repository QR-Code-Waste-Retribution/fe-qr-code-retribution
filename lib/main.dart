import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/binding.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/core/firebase/firebase_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final firebaseProvider = FirebaseProvider();
  // await firebaseProvider.initFirebase();

  await GetStorage.init();
  AppBindings().dependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute:
          _authProvider.checkAuth() ? Pages.homePage : Pages.loginPage,
      initialBinding: AppBindings(),
    );
  }
}
