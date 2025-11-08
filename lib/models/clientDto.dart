class ClientDto {
  int? clientId;
  String? firstName;
  String? surname;
  String? about;
  String? mobileNumber;
  String? emailAddress;

  ClientDto(
      {this.clientId,
      this.firstName,
      this.surname,
      this.about,
      this.mobileNumber,
      this.emailAddress});

  ClientDto.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    firstName = json['firstName'];
    surname = json['surname'];
    about = json['about'] ?? '';
    mobileNumber = json['mobileNumber'] ?? '';
    emailAddress = json['emailAddress'] ?? '';
  }
}
