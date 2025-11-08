import 'package:get/get.dart';

import '../clientController.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientController());
  }
}
