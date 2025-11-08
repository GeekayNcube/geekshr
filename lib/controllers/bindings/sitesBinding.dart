import 'package:geekshr/controllers/siteController.dart';
import 'package:get/get.dart';

class SitesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SitesController());
  }
}
