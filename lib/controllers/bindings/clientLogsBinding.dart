import 'package:get/get.dart';

import '../clientLogsController.dart';

class ClientLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientLogsController());
  }
}
