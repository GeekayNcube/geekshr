import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geekshr/config/successSnackBar.dart';
import 'package:geekshr/models/leaveApplicationTypesDto.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/leaveApplicationDto.dart';
import '../views/routes/routes.dart';
import 'baseController.dart';

class LeaveApplicationController extends BaseController {
  RxList<LeaveApplicationDto> leaves = RxList<LeaveApplicationDto>();

  List<DropdownMenuItem<String>>? leaveApplicationTypesData = [];
  late MainRepository _mainRepository;
  var dateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 360)),
    end: DateTime.now().add(const Duration(days: 360)),
  ).obs;

  var applicationRange = DateTimeRange(
    start: DateTime.now().add(const Duration(days: 1)),
    end: DateTime.now().add(const Duration(days: 3)),
  ).obs;
  TextEditingController dateSelectControl = TextEditingController(text: "");
  TextEditingController noteSelectControl = TextEditingController(text: "");
  var numberOfDays = 1.obs;
  var leaveApplicationTypeId = 0.obs;

  LeaveApplicationController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getData() async {
    leaves.clear();

    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getLeaves(
      dateTimeRange.value.start,
      dateTimeRange.value.end,
    );
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult(r));

    return leaves;
  }

  getLeaveType() async {
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getLeaveApplicationTypes();
    EasyLoading.dismiss();
    data.fold(
      (l) => errorSnackbar(msg: l.message),
      (r) => _sucessResultTypes(r),
    );

    return leaveApplicationTypesData;
  }

  sendRequest() async {
    if (numberOfDays.value == 0 || leaveApplicationTypeId.value == 0) {
      errorSnackbar(msg: "Number of days and leave application type required ");
      return 0;
    }

    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.requestLeave(
      applicationRange.value.start,
      applicationRange.value.end,
      leaveApplicationTypeId.value,
      numberOfDays.value,
      noteSelectControl.text,
    );
    EasyLoading.dismiss();
    data.fold(
      (l) => errorSnackbar(msg: l.message),
      (r) => _sucessResultApplication(r),
    );

    return 1;
  }

  _sucessResult(List<LeaveApplicationDto> list) {
    for (var element in list) {
      leaves.add(element);
    }
  }

  _sucessResultTypes(List<LeaveApplicationTypesDto> list) {
    for (var element in list) {
      leaveApplicationTypesData?.add(
        DropdownMenuItem(
          value: element.leaveApplicationTypeId.toString(),
          child: Text(element.description!),
        ),
      );
    }
  }

  _sucessResultApplication(int r) {
    successSnackBar("Leave request submitted");
    Get.toNamed(Routes.DASHBOARD);
  }

  cancelLeave(int leaveApplicationId) async {
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.cancelLeaveApplication(leaveApplicationId);

    data.fold(
      (l) =>
          errorSnackbar(msg: "Leave could not be cancelled, please try again"),
      (r) => successSnackBar("Leave request cancelled"),
    );

    EasyLoading.dismiss();
  }
}
