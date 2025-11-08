import 'package:get/get.dart';

import '../signInController.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
