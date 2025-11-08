import 'package:geekshr/models/User.dart';

import 'clientLogTypeDto.dart';

class ClientLogDto {
  int? clientLogId;
  String? notes;
  ClientLogTypeDto? clientLogType;
  User? user;
  String? loggedDate;
  String? imageLink;

  ClientLogDto({
    this.clientLogId,
    this.notes,
    this.clientLogType,
    this.user,
    this.loggedDate,
    this.imageLink,
  });

  ClientLogDto.fromJson(Map<String, dynamic> json) {
    clientLogId = json['clientLogId'];
    notes = json['notes'] ?? 'No notes';
    imageLink = json['imageLink'] ?? '';
    clientLogType = json['clientLogType'] != null
        ? ClientLogTypeDto.fromJson(json['clientLogType'])
        : null;
    user = json['user'] != null ? User().fromJson(json['user'], false) : null;
    loggedDate = json['loggedDate'];
  }
}
