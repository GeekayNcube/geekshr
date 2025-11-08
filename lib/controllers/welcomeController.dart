import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/routes/routes.dart';
import 'baseController.dart';

class WelcomeController extends BaseController {
  PageController? controller;
  var currentIndex = 0.obs;
  WelcomeController() {
    controller = PageController(initialPage: 0);
  }

  signIn() {
    Get.toNamed(Routes.SIGNIN);
  }

  @override
  dispose() {
    controller!.dispose();
    super.dispose();
  }
}
