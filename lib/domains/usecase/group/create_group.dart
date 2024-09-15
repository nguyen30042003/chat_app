import 'package:chat_project/domains/repository/group_repository.dart';
import 'package:chat_project/requests/group_request.dart';
import 'package:chat_project/utils/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../models/group.dart';
import '../../../service_locator.dart';


class CreateGroupUseCases implements UseCase<Group, GroupRequest> {
  @override
  Future<Group> call({GroupRequest? params}) async {
    return await sl<GroupRepository>().createGroup(params!);
  }
}