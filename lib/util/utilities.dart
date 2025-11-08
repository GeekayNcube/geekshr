import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geekshr/config/errorSnackBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class Utilities {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      errorSnackbar(msg: "Could not open");
    }
  }

  static Future<Position?> getPosition() async {
    EasyLoading.show(status: 'loading...');
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      EasyLoading.dismiss();
      errorSnackbar(msg: "Location services are disabled.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        EasyLoading.dismiss();
        errorSnackbar(msg: "Location services are denied.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      EasyLoading.dismiss();
      errorSnackbar(msg: "Location permissions are permanently denied, we cannot request permissions.");
      return null;
    }
    EasyLoading.dismiss();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
