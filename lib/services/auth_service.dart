import 'package:chat_project/requests/signin_request.dart';
import 'package:dartz/dartz.dart';
import '../models/user.dart';

abstract class AuthService {
  Future<Either> signin(SigninRequest signinRequest);
}
