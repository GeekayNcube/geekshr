import 'package:get/get.dart';

import '../userController.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}
