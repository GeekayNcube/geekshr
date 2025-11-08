import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/scheduleDto.dart';

class ScheduleController extends GetxController {
  late MainRepository _mainRepository;
  RxList<ScheduleDto> schedules = RxList<ScheduleDto>();
  ScheduleController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getData(DateTime start, DateTime endDate) async {
    schedules.clear();
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getSchedules(start, endDate, 1, 1000);
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult(r));

    return schedules;
  }

  _sucessResult(List<ScheduleDto> list) {
    schedules.clear();

    for (var element in list) {
      schedules.add(element);
    }
  }
}
