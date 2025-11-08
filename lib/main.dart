import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geekshr/util/app_sdk_manager.dart';
import 'package:geekshr/views/routes/appPages.dart';
import 'package:geekshr/views/splashPage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'config/dark_theme.dart';
import 'config/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppSDKManager.getInstance().initializeSdks();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  initLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => PasswordProvider())],
        child: GetMaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          getPages: AppPages.pages,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class PasswordProvider with ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure {
    return _isObscure;
  }

  void toggleIsObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}

void initLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.black
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
