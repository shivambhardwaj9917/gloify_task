import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_page/login_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.to(LoginScreen());
      },
    );

    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/logo.png',
              ),
              fit: BoxFit.cover,
            ), //DecorationImage
          ), //BoxDecoration
        ),
      ),
    );
  }
}
