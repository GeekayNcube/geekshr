import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geekshr/models/announcement.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import 'baseController.dart';

class AnnouncementController extends BaseController {
  RxList<AnnouncementDto> announcement = RxList<AnnouncementDto>();
  TextEditingController textControllor = TextEditingController();
  late MainRepository _mainRepository;

  AnnouncementController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getData() async {
    announcement.clear();

    EasyLoading.show(status: 'loading...');
    var announcementResult = await _mainRepository.getAnnouncements(
      1,
      50,
      textControllor.text,
    );
    EasyLoading.dismiss();
    announcementResult.fold(
      (l) => errorSnackbar(msg: l.message),
      (r) => _sucessResult(r),
    );

    return announcement;
  }

  _sucessResult(List<AnnouncementDto> list) {
    for (var element in list) {
      announcement.add(element);
    }
  }
}
