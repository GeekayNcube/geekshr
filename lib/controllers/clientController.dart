import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geekshr/models/clientDto.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/clientDetailDto.dart';
import 'baseController.dart';

class ClientController extends BaseController {
  RxList<ClientDto> clients = RxList<ClientDto>();
  late MainRepository _mainRepository;
  late ClientDetailDto clientDetailDto;
  ClientController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getData(int siteId) async {
    clients.clear();
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getClients(siteId);
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult(r));

    return clients;
  }

  getClient(int clientId) async {
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getClient(clientId);
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => clientDetailDto = r);
  }

  _sucessResult(List<ClientDto> list) {
    clients.clear();

    for (var element in list) {
      clients.add(element);
    }
  }
}
