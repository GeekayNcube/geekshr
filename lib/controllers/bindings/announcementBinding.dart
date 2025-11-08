import 'package:get/get.dart';

import '../AnnouncementController.dart';

class AnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnnouncementController());
  }
}
