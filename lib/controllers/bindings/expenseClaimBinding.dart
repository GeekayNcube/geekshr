import 'package:get/get.dart';

import '../expenseClaimController.dart';

class ExpenseClaimBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpenseClaimController());
  }
}
