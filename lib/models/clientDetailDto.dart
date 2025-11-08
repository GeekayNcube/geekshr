import 'medicationDto.dart';

class ClientDetailDto {
  int? clientId;
  String? firstName;
  String? surname;
  String? about;
  String? mobileNumber;
  List<Medications>? medications;

  ClientDetailDto(
      {this.clientId,
      this.firstName,
      this.surname,
      this.about,
      this.mobileNumber,
      this.medications});

  ClientDetailDto.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    firstName = json['firstName'];
    surname = json['surname'];
    about = json['about'];
    mobileNumber = json['mobileNumber'] ?? '';
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications!.add(Medications.fromJson(v));
      });
    }
  }
}
