class ClientLogTypeDto {
  int? clientLogTypeId;
  String? description;
  String? code;

  ClientLogTypeDto({this.clientLogTypeId, this.description, this.code});

  ClientLogTypeDto.fromJson(Map<String, dynamic> json) {
    clientLogTypeId = json['clientLogTypeId'];
    description = json['description'];
    code = json['code'];
  }
}
