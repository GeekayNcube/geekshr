class ExpenseClaimDto {
  int? expenseClaimId;
  String? title;
  int? userId;
  String? user;
  String? notes;
  int? expenseClaimStatusId;
  String? expenseClaimStatus;
  String? imageLink;
  String? expenseDate;
  double? amount;

  ExpenseClaimDto.fromJson(Map<String, dynamic> json) {
    expenseClaimId = json['expenseClaimId'];
    title = json['title'];
    userId = json['userId'];
    user = json['user'];
    notes = json['notes'];
    expenseClaimStatusId = json['expenseClaimStatusId'];
    expenseClaimStatus = json['expenseClaimStatus'];
    imageLink = json['imageLink'];
    expenseDate = json['expenseDate'];
    amount = json['amount'].toDouble();
  }
}
