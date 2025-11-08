import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackbar({required String msg, int duration = 5}) {
  Get.snackbar("Error!", msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[200],
      animationDuration: const Duration(seconds: 2),
      duration: Duration(seconds: duration),
      colorText: Colors.white);
}
