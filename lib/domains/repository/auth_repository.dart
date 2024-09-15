import 'package:chat_project/requests/signin_request.dart';
import 'package:chat_project/requests/user_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either> signin(SigninRequest signinRequest);
}