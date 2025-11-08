class User {
  late int userId;
  late String firstName;
  late String lastName;
  late String emailAddress;
  late String mobileNumber;
  late String token;

  late String userName;
  late String address;
  late String IDNumber;
  late String IDExpirydate;
  late String DOB;
  late String profileLink;
  late String contractStartDate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['MobileNumber'] = mobileNumber;
    data['EmailAddress'] = emailAddress;
    data['UserId'] = userId;
    return data;
  }

  fromJson(Map<String, dynamic> json, bool loadAll) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (loadAll) {
      mobileNumber = json['mobileNumber'] ?? '';
      emailAddress = json['emailAddress'];
      token = json['token'];
      userName = json['userName'];
      address = json['address'] ?? '';
      IDNumber = json['iDNumber'] ?? '';
      IDExpirydate = json['iDExpirydate'] ?? '';
      DOB = json['dOB'] ?? '';
      profileLink = json['profileLink'] ?? '';
      contractStartDate = json['contractStartDate'] ?? '';
    }

    return this;
  }
}
