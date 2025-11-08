import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geekshr/config/successSnackBar.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/clientLogDto.dart';
import '../models/clientLogTypeDto.dart';
import 'baseController.dart';

class ClientLogsController extends BaseController {
  RxList<ClientLogDto> clientLogs = RxList<ClientLogDto>();
  RxList<ClientLogTypeDto> clientLogTypes = RxList<ClientLogTypeDto>();
  TextEditingController notes = TextEditingController(text: "");
  var clientTypeLogId = 0.obs;
  String image = "";
  List<DropdownMenuItem<String>>? clientLogTypesData = [];
  late MainRepository _mainRepository;

  ClientLogsController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getData(DateTime start, DateTime endDate, int clientId) async {
    clientLogs.clear();
    EasyLoading.show(status: 'loading...');

    var data = await _mainRepository.getClientLogs(
      start,
      endDate,
      1,
      10,
      clientId,
    );
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult(r));

    return clientLogs;
  }

  save(int clientId) async {
    if (clientId == 0) {
      errorSnackbar(msg: "Client is required");
      return 0;
    }

    if (clientTypeLogId.value == 0) {
      errorSnackbar(msg: "Log type is required");
      return 0;
    }
    int clientLogId = 0;

    var data = await _mainRepository.saveClientLog(
      notes.text,
      clientTypeLogId.value,
      clientId,
      image,
    );
    data.fold((l) => errorSnackbar(msg: l.message), (r) => clientLogId = r);

    if (clientLogId > 0) {
      successSnackBar("Log saved successful");
    }

    return clientLogId;
  }

  getClientLogTypes() async {
    if (clientLogTypes.isNotEmpty) {
      return clientLogTypes;
    }

    var data = await _mainRepository.getClientLogTypes();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessLogResult(r));

    return clientLogTypes;
  }

  _sucessResult(List<ClientLogDto> list) {
    clientLogs.clear();

    for (var element in list) {
      clientLogs.add(element);
    }
  }

  _sucessLogResult(List<ClientLogTypeDto> list) {
    clientLogTypes.clear();

    for (var element in list) {
      clientLogTypes.add(element);

      clientLogTypesData?.add(
        DropdownMenuItem(
          value: element.clientLogTypeId.toString(),
          child: Text(element.description!),
        ),
      );
    }
  }
}
