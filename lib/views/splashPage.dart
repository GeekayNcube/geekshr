import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geekshr/views/routes/routes.dart';
import 'package:get/get.dart';

import '../util/preferences_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () async {
      var userId = PreferencesManager.getInstance().getIntValue("userId");

      if (userId == 0) {
        Get.offAllNamed(Routes.OnBoarding);
      } else {
        Get.offAllNamed(Routes.SIGNIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.h,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
