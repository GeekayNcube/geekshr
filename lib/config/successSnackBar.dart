import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController successSnackBar(String msg) {
  return Get.snackbar("Message", msg,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      animationDuration: const Duration(seconds: 2),
      duration: const Duration(seconds: 5),
      colorText: Colors.white);
}
