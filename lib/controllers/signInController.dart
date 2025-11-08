import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../config/successSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/User.dart';
import '../models/loginDTO.dart';
import '../models/resetPassword.dart';
import '../util/preferences_manager.dart';
import '../views/routes/routes.dart';
import 'baseController.dart';

class SignInController extends BaseController {
  final TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  late MainRepository _mainRepository; // this will always have all our services
  // this is required all controllers
  SignInController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  signIn() {
    Get.toNamed(Routes.SIGNIN);
  }

  login() async {
    // check whether the TextEditingController are empty
    if (!usernameController.text.isNotEmpty &&
        !passwordController.text.isNotEmpty) {
      errorSnackbar(msg: 'Make sure all the fields are filled');
      return;
    }

    String token =
        PreferencesManager.getInstance().getStringValue('firebasetoken');
    LoginDto loginDto =
        LoginDto(passwordController.text, usernameController.text, token);
    EasyLoading.show(status: 'please wait...');
    final user = await _mainRepository.login(loginDto);
    EasyLoading.dismiss();

    user?.fold(
      (l) => {errorSnackbar(msg: l.message)},

      // show error
      (r) => {_processLogin(r)},
    );
  }

  _processLogin(User user) {
    PreferencesManager.getInstance().setStringValue('token', user.token);
    PreferencesManager.getInstance().setIntValue('userId', user.userId);
    PreferencesManager.getInstance()
        .setStringValue('firstName', user.firstName);
    PreferencesManager.getInstance().setStringValue('lastName', user.lastName);
    PreferencesManager.getInstance().setStringValue('email', user.emailAddress);
    PreferencesManager.getInstance()
        .setStringValue('username', usernameController.text);

    PreferencesManager.getInstance().setStringValue('IDNumber', user.IDNumber);
    PreferencesManager.getInstance()
        .setStringValue('IDExpirydate', user.IDExpirydate);
    PreferencesManager.getInstance().setStringValue('DOB', user.DOB);
    PreferencesManager.getInstance()
        .setStringValue('profileLink', user.profileLink);
    PreferencesManager.getInstance()
        .setStringValue('contractStartDate', user.contractStartDate);
    PreferencesManager.getInstance().setStringValue('address', user.address);
    PreferencesManager.getInstance()
        .setStringValue('mobileNumber', user.mobileNumber);
    // redirect to dashboard
    Get.toNamed(Routes.DASHBOARD);
  }

  forgotPassword() async {
    if (usernameController.text.isNotEmpty) {
      isLoading(true);
      EasyLoading.show(status: 'loading...');
      ResetPasswordDto resetDto = ResetPasswordDto(usernameController.text);
      var reset = await _mainRepository.resetPassword(resetDto);
      EasyLoading.dismiss();
      isLoading(false);

      reset?.fold(
          (l) => errorSnackbar(msg: l.message),
          (r) => successSnackBar(
              "Message containing password sent to your email address"));
    } else {
      errorSnackbar(msg: "Enter user name");
    }
  }
}
