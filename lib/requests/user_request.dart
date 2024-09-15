class UserRequest {
  String fullName;
  String email;
  String userName;
  String password;
  String role;

  UserRequest({
    required this.fullName,
    required this.email,
    required this.userName,
    required this.password,
    required this.role,
  });

  // Convert UserRequest instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'password': password,
      'role': role,
    };
  }
}
