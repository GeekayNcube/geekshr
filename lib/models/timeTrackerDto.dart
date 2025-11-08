class TimeTrackerDto {
  int? timeTrackerId;
  int? userId;
  String? notes;
  String? checkIn;
  String? checkOut;
  bool? checkedOut;
  // double? checkInLong;
  String? status;
  //double? checkOutLat;
  // double? checkOutLong;
  String? site;

  TimeTrackerDto(
      {this.timeTrackerId,
      this.userId,
      this.notes,
      this.checkIn,
      this.checkOut,
      // this.checkInLat,
      //this.checkInLong,
      this.status,
      //this.checkOutLat,
      this.checkedOut,
      this.site});

  TimeTrackerDto.fromJson(Map<String, dynamic> json) {
    timeTrackerId = json['timeTrackerId'];
    userId = json['userId'];
    notes = json['notes'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'] ?? 'Not checked out';
    //checkInLat = json['checkInLat'];
    //checkInLong = json['checkInLong'];
    status = json['status'];
    //checkOutLat = json['checkOutLat'] ?? '';
    checkedOut = json['checkedOut'];
    site = json['site'] ?? 'No Site';
  }
}
