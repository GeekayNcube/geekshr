import 'package:geekshr/util/preferences_manager.dart';

class AppSDKManager {
  static late AppSDKManager _appManagerInstance;

  ///get the instance of the manager
  static AppSDKManager getInstance() {
    _appManagerInstance = AppSDKManager._();
    return _appManagerInstance;
  }

  AppSDKManager._();

  ///initialize the Firebase or any other SDKs here
  ///the method is async in nature and will respond in background
  ///all the SDKs that need to be initialize before the app UI renders,
  ///should be initialize here at the background
  Future<void> initializeSdks() async {
    await PreferencesManager.getInstance().getPreferences();
  }
}
