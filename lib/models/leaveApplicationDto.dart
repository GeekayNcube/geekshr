class LeaveApplicationDto {
  int? leaveApplicationId;
  int? userId;
  String? firstName;
  String? surname;
  String? startDate;
  String? endDate;
  int? numberOfDays;
  String? leaveApplicationType;
  String? leaveApplicationStatus;
  String? notes;

  LeaveApplicationDto(
      {this.leaveApplicationId,
      this.userId,
      this.firstName,
      this.surname,
      this.startDate,
      this.endDate,
      this.numberOfDays,
      this.leaveApplicationType,
      this.leaveApplicationStatus,
      this.notes});

  LeaveApplicationDto.fromJson(Map<String, dynamic> json) {
    leaveApplicationId = json['leaveApplicationId'];
    userId = json['userId'];
    firstName = json['firstName'];
    surname = json['surname'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    numberOfDays = json['numberOfDays'];
    leaveApplicationType = json['leaveApplicationType'];
    leaveApplicationStatus = json['leaveApplicationStatus'];
    notes = json['notes'];
  }
}
