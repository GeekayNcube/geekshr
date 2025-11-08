import 'package:get/get.dart';

import '../welcomeController.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController(), fenix: true);
  }
}
