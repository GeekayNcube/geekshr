import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/siteDto.dart';
import '../util/utilities.dart';
import 'baseController.dart';

class SitesController extends BaseController {
  late MainRepository _mainRepository;
  RxList<SiteDto> sites = RxList<SiteDto>();

  SitesController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getSiteNear() async {
    sites.clear();
    var location = await Utilities.getPosition();
    double lat = 0;
    double longi = 0;
    if (location == null) {
      errorSnackbar(msg: "We couldn't access your location.");
      return sites;
    }
    else
      {
        lat = location.latitude;
        longi = location.longitude;
      }
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getSitesByLocation(
        lat, longi);
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessSites(r));

    return sites;
  }

  _sucessSites(List<SiteDto> list) {
    sites.clear();

    for (var element in list) {
      sites.add(element);
    }
  }
}
