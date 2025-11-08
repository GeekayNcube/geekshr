import 'package:get/get.dart';

import '../config/errorSnackBar.dart';

class BaseController extends GetxController {
  RxBool isLoading = false.obs;

  onError(String error) {
    isLoading(false);
    if (error.isNotEmpty) {
      errorSnackbar(msg: error);
    } else {
      errorSnackbar(msg: "Error occured, please contact us for support");
    }
  }
}
