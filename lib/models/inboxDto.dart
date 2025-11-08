class InboxDto {
  int? inboxId;
  String? description;
  String? subject;
  int? userId;
  bool? isRead;
  String? imageLink;
  bool? pushed;
  DateTime? created;

  InboxDto(
      {this.inboxId,
      this.description,
      this.subject,
      this.userId,
      this.isRead,
      this.imageLink,
      this.pushed,
      this.created});

  InboxDto.fromJson(Map<String, dynamic> json) {
    inboxId = json['inboxId'];
    description = json['description'];
    subject = json['subject'];
    userId = json['userId'];
    isRead = json['isRead'];
    imageLink = json['imageLink'];
    pushed = json['pushed'];
    DateTime parseDate = DateTime.parse(json['created']);
    created = parseDate;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inboxId'] = inboxId;
    data['description'] = description;
    data['subject'] = subject;
    data['userId'] = userId;
    data['isRead'] = isRead;
    data['imageLink'] = imageLink;
    data['pushed'] = pushed;
    return data;
  }
}
