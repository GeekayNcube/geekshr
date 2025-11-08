import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../config/errorSnackBar.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String addess) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = 'https://www.google.com/maps/search/?api=1&query=$addess';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        errorSnackbar(msg: 'Could not open the map.');
      }
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$addess';
      url = 'comgooglemaps://?saddr=&daddr=$addess&directionsmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        errorSnackbar(msg: 'Could not open the map.');
      }
    }
  }
}
