import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  RxBool isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    isLoggedIn.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    Get.offAllNamed('/home');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Get.offAllNamed('/login');
  }
}