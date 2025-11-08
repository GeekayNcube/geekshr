import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../config/successSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../views/routes/routes.dart';
import 'baseController.dart';

class ProfileController extends BaseController {
  late MainRepository _mainRepository;
  ProfileController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  signIn() {
    Get.toNamed(Routes.SIGNIN);
  }

  delete() async {
    EasyLoading.show(status: 'loading...');
    var result = await _mainRepository.delete();
    EasyLoading.dismiss();
    result.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult());
  }

  _sucessResult() {
    successSnackBar("Password changed successful");
    Get.toNamed(Routes.SIGNIN);
  }
}
