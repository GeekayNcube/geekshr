import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../config/successSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/changePasswordDto.dart';
import '../views/routes/routes.dart';
import 'baseController.dart';

class ChangePasswordController extends BaseController {
  var password = "".obs;
  var newPassword = "".obs;
  var confirmPassword = "".obs;
  late MainRepository _mainRepository;
  ChangePasswordController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  changePassword() async {
    if (password.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      errorSnackbar(msg: "All fields are required");
      return false;
    }
    if (newPassword.value != confirmPassword.value) {
      errorSnackbar(msg: "New and confirm password do not match");
      return false;
    }
    ChangePasswordDto changePasswordDto =
        ChangePasswordDto(password.value, newPassword.value);
    EasyLoading.show(status: 'loading...');
    var result = await _mainRepository.changePassword(changePasswordDto);
    EasyLoading.dismiss();
    result.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult());
  }

  _sucessResult() {
    successSnackBar("Password changed successful");
    Get.toNamed(Routes.DASHBOARD);
  }
}
