class ChangePasswordDto {
  String currentPassword;
  String newPassword;

  ChangePasswordDto(this.currentPassword, this.newPassword);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NewPassword'] = newPassword;
    data['CurrentPassword'] = currentPassword;
    return data;
  }
}
