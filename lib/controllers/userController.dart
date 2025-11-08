import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/userDTo.dart';

class UserController extends GetxController {
  late MainRepository _mainRepository;
  RxList<SingleUser> users = RxList<SingleUser>();
  late UserDto? userDto;
  var pageNumber = 1;
  TextEditingController textControllor = TextEditingController();
  UserController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  search() async {
    if (pageNumber == 1) users.clear();

    var result = await _mainRepository.getUsers(
      textControllor.text,
      pageNumber,
      10,
    );

    result.fold((l) => (), (r) => userDto = r);
    if (userDto != null && userDto?.users != null) {
      for (var value in userDto!.users) {
        users.add(value);
      }
    }

    return users;
  }

  Future<RxList<SingleUser>> nextProducts() async {
    pageNumber = pageNumber + 1;
    return search();
  }
}
