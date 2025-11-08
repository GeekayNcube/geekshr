class LoginDto {
  String password;
  String username;
  String firebaseToken;

  LoginDto(this.password, this.username, this.firebaseToken);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = username;
    data['Password'] = password;
    data['FirebaseToken'] = firebaseToken;
    return data;
  }
}
