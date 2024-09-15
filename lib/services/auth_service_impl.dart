import 'package:chat_project/services/user_service_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../requests/signin_request.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  final UserServiceImpl userService = UserServiceImpl();

  @override
  Future<Either> signin(SigninRequest signinRequest) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      User user = await userService.findByUserName(signinRequest.username);

      if (user.password != null) {
        var result2 = await FlutterBcrypt.verify(
          password: signinRequest.password,
          hash: user.password!,
        );

        if (result2) {
          await prefs.setString('username', signinRequest.username);
          await prefs.setString('password', signinRequest.password);
          await prefs.setInt('userId', user.userId!);
          return Right(user);
        } else {
          return const Left('Invalid password');
        }
      } else {
        return const Left('User not found');
      }
    } catch (e) {
      return const Left('An error occurred');
    }
  }
}