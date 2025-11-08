class SiteDto {
  int? siteId;
  String? description;
  String? address;

  SiteDto.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    description = json['description'];
    address = json['address'] ?? '';
  }
}
