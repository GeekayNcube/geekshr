import 'package:get/get.dart';

import '../leaveApplicationController.dart';

class LeaveApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LeaveApplicationController());
  }
}
