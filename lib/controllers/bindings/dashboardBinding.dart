import 'package:get/get.dart';

import '../dashboardController.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
