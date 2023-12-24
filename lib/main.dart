import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gloify_task/screens/home_page/home_view.dart';
import 'package:gloify_task/screens/login_page/login_view.dart';
import 'package:gloify_task/services/auth_service.dart';
import 'screens/splash_page/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthService());
    return GetMaterialApp(
      home: Get.find<AuthService>().isLoggedIn.value ? HomePage() : const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService(), permanent: true);
      }),
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}

