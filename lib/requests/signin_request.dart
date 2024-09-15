class SigninRequest {
  SigninRequest({required this.username, required this.password});
  String username;
  String password;
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password
    };
  }
}