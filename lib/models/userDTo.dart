class UserDto {
  late List<SingleUser> users;
  int? pageIndex;
  int? totalPages;
  int? totalCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  UserDto.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      users = <SingleUser>[];
      json['items'].forEach((v) {
        users.add(SingleUser.fromJson(v));
      });
    }
    pageIndex = json['pageIndex'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['items'] = users!.map((v) => v.toJson()).toList();
    }
    data['pageIndex'] = pageIndex;
    data['totalPages'] = totalPages;
    data['totalCount'] = totalCount;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    return data;
  }
}

class SingleUser {
  int? userId;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? mobileNumber;
  String? userName;

  SingleUser(
      {this.userId,
      this.firstName,
      this.lastName,
      this.emailAddress,
      this.mobileNumber,
      this.userName});

  SingleUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailAddress = json['emailAddress'];
    mobileNumber = json['mobileNumber'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emailAddress'] = emailAddress;
    data['mobileNumber'] = mobileNumber;
    data['userName'] = userName;
    return data;
  }
}
