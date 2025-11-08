import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geekshr/models/siteDto.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/timeTrackerDto.dart';
import '../util/utilities.dart';
import 'baseController.dart';

class TimeTrackerController extends BaseController {
  late MainRepository _mainRepository;
  RxList<TimeTrackerDto> times = RxList<TimeTrackerDto>();
  RxList<SiteDto> sites = RxList<SiteDto>();
  List<DropdownMenuItem<String>> sitesDropDownlist = [];
  int siteId = 0;
  int timeTrackerId = 0;
  bool saved = false;
  TimeTrackerController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  @override
  dispose() {
    super.dispose();
  }

  getData() async {
    times.clear();

    DateTime start = DateTime.now().subtract(const Duration(days: 90));
    DateTime endDate = DateTime.now().add(const Duration(days: 1));
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getTimeTrackerQueryByUser(
      "",
      0,
      "",
      start,
      endDate,
      1,
      1000,
    );
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult(r));

    return times;
  }

  getSiteNear() async {
    sites.clear();
    var location = await Utilities.getPosition();
    double lat = 0;
    double longi = 0;
    if (location == null) {
      errorSnackbar(msg: "We couldn't access your location.");
      return sites;
    }else
      {
        lat = location.latitude;
        longi = location.longitude;
      }
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getSitesByLocation(
      lat,
      longi,
    );
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessSites(r));

    return sites;
  }

  _sucessResult(List<TimeTrackerDto> list) {
    times.clear();

    for (var element in list) {
      times.add(element);
    }
  }

  checkIn(bool checkIn) async {
    var location = await Utilities.getPosition();
    if (location == null) {
      errorSnackbar(msg: "We couldn't access your location.");
      return false;
    }
    if (checkIn) {
      if (siteId == 0) {
        errorSnackbar(msg: "Please select site.");
        return false;
      }
    }

    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.trackerSave(
      timeTrackerId,
      "",
      checkIn,
      location.longitude,
      location.latitude,
      location.latitude,
      location.longitude,
      siteId,
    );
    EasyLoading.dismiss();

    data.fold((l) => errorSnackbar(msg: l.message), (r) => saved = true);
    await getData();
    return saved;
  }

  _sucessSites(List<SiteDto> list) {
    sites.clear();

    for (var element in list) {
      sites.add(element);
    }

    sitesDropDownlist = List.generate(
      sites.length,
      (index) => DropdownMenuItem(
        value: sites.value[index].siteId.toString(),
        child: Text(sites.value[index].description.toString()),
      ),
    );
  }
}
