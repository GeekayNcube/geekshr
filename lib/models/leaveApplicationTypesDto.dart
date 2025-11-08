class LeaveApplicationTypesDto {
  int? leaveApplicationTypeId;
  String? description;
  String? code;

  LeaveApplicationTypesDto(
      {this.leaveApplicationTypeId, this.description, this.code});

  LeaveApplicationTypesDto.fromJson(Map<String, dynamic> json) {
    leaveApplicationTypeId = json['leaveApplicationTypeId'];
    description = json['description'];
    code = json['code'];
  }
}
