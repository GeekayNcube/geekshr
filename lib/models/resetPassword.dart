class ResetPasswordDto {
  String userName;

  ResetPasswordDto(this.userName);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['useName'] = userName;
    return data;
  }
}
