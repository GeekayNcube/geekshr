import 'package:get/get.dart';

import '../timeTrackerController.dart';

class TimeTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TimeTrackerController());
  }
}
