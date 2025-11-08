import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../config/errorSnackBar.dart';
import '../config/successSnackBar.dart';
import '../core/repositories/mainRepository.dart';
import '../core/repositories/mainRepository_impl.dart';
import '../models/expenseClaimDto.dart';
import '../views/routes/routes.dart';
import 'baseController.dart';

class ExpenseClaimController extends BaseController {
  late MainRepository _mainRepository;
  RxList<ExpenseClaimDto> expenseClaims = RxList<ExpenseClaimDto>();
  TextEditingController date = TextEditingController(text: "");
  var comments = "".obs;
  var amount = "".obs;
  var title = "".obs;
  var transactionDateTime = DateTime.now().obs;
  String image = "";

  ExpenseClaimController() {
    _mainRepository = Get.put(MainRepositoryImplementation());
  }

  getData() async {
    expenseClaims.clear();
    DateTime start = DateTime.now().subtract(const Duration(days: 90));
    DateTime endDate = DateTime.now().add(const Duration(days: 1));
    EasyLoading.show(status: 'loading...');
    var data = await _mainRepository.getExpenseClaims(
        "", 0, "", start, endDate, 1, 1000);
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessResult(r));

    return expenseClaims;
  }

  sendRequest() async {
    if (title.isEmpty || date.text.isEmpty || amount.isEmpty || image.isEmpty) {
      errorSnackbar(msg: "Title, amount, date and proof of payment required");
      return;
    }
    EasyLoading.show(status: 'loading...');

    var data = await _mainRepository.claim(transactionDateTime.value,
        double.parse(amount.value), title.value, comments.value, image!);
    EasyLoading.dismiss();
    data.fold((l) => errorSnackbar(msg: l.message), (r) => _sucessClaim());
    EasyLoading.dismiss();
  }

  getClaim(int claimId) async {
    expenseClaims.clear();

    return expenseClaims;
  }

  _sucessResult(List<ExpenseClaimDto> list) {
    expenseClaims.clear();

    for (var element in list) {
      expenseClaims.add(element);
    }
  }

  _sucessClaim() {
    successSnackBar("Claim submitted successful");
    Get.toNamed(Routes.DASHBOARD);
  }
}
