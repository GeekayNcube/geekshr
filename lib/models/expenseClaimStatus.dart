class ExpenseClaimStatusDto {
  int? expenseClaimStatusId;
  String? description;
  String? code;

  ExpenseClaimStatusDto(
      {this.expenseClaimStatusId, this.description, this.code});

  ExpenseClaimStatusDto.fromJson(Map<String, dynamic> json) {
    expenseClaimStatusId = json['expenseClaimStatusId'];
    description = json['description'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['expenseClaimStatusId'] = expenseClaimStatusId;
    data['description'] = description;
    data['code'] = code;
    return data;
  }
}
