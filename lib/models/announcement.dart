class AnnouncementDto {
  int? announcementId;
  String? title;
  String? description;
  String? startDateFormated;
  String? endDateFormated;

  AnnouncementDto(
      {this.announcementId,
      this.title,
      this.description,
      this.startDateFormated,
      this.endDateFormated});

  AnnouncementDto.fromJson(Map<String, dynamic> json) {
    announcementId = json['announcementId'];
    title = json['title'];
    description = json['description'];
    startDateFormated = json['startDateFormated'];
    endDateFormated = json['endDateFormated'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['announcementId'] = announcementId;
    data['title'] = title;
    data['description'] = description;
    data['endDateFormated'] = endDateFormated;
    data['endDateFormated'] = endDateFormated;
    return data;
  }
}
