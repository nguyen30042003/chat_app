import 'package:chat_project/domains/repository/auth_repository.dart';
import 'package:chat_project/requests/signin_request.dart';
import 'package:chat_project/utils/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../service_locator.dart';

class Login implements UseCase<Either, SigninRequest> {
  @override
  Future<Either> call({SigninRequest? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}