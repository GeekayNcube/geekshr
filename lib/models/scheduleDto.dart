import 'package:geekshr/models/siteDto.dart';

class ScheduleDto {
  int? scheduleId;
  String? notes;
  SiteDto? site;
  String? startDateFormatted;
  String? endDateFormatted;

  ScheduleDto({
    this.scheduleId,
    this.notes,
    this.site,
    this.startDateFormatted,
    this.endDateFormatted,
  });

  ScheduleDto.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    notes = json['notes'];
    site = json['site'] != null ? SiteDto.fromJson(json['site']) : null;
    startDateFormatted = json['startDateFormatted'];
    endDateFormatted = json['endDateFormatted'];
  }
}
