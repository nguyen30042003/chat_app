import 'package:chat_project/domains/repository/auth_repository.dart';
import 'package:chat_project/services/auth_service.dart';
import 'package:dartz/dartz.dart';

import '../../requests/signin_request.dart';
import '../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SigninRequest signinRequest) async {
    return await sl<AuthService>().signin(signinRequest);
  }
}