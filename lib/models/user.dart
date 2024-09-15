class User {
  int? userId;
  String? fullName;
  String? birthDay;
  bool? gender;
  String? email;
  String? timeRegister;
  String? userName;
  String? password;
  String? role;
  bool? active;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    birthDay = json['birthDay'];
    gender = json['gender'];
    email = json['email'];
    timeRegister = json['timeRegister'];
    userName = json['userName'];
    password = json['password'];
    role = json['role'];
    active = json['active'];
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'birthDay': birthDay,
      'gender': gender,
      'email': email,
      'timeRegister': timeRegister,
      'userName': userName,
      'password': password,
      'role': role,
      'active': active,
    };
  }
}
