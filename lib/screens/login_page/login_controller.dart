import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart';
import '../home_page/home_view.dart';

class LoginController extends GetxController {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = Get.find();

  final RxString username = ''.obs;
  final RxString password = ''.obs;

  void onUsernameChanged(String value) {
    username.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  Future<void> login() async {
    await _authService.login(username.value, password.value);
    if (_authService.isLoggedIn.value) {
      Get.to(HomePage());
    }
  }
}