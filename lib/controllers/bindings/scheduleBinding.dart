import 'package:get/get.dart';

import '../ScheduleController.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScheduleController());
  }
}
