import 'package:get/get.dart';

import '../changePasswordController.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}
