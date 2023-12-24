import 'package:get/get.dart';

import 'home_controller.dart';

class NoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteController());
  }
}