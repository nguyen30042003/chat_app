import 'package:chat_project/domains/repository/group_repository.dart';
import 'package:chat_project/models/connection.dart';
import 'package:chat_project/models/group.dart';
import 'package:chat_project/models/message.dart';
import 'package:chat_project/models/page_group.dart';
import 'package:chat_project/models/user.dart';
import 'package:chat_project/requests/group_request.dart';
import 'package:chat_project/services/group_service.dart';

import '../../service_locator.dart';

class GroupRepositoryImpl extends GroupRepository{
  @override
  Future<Group> addAdmin(int idGroup, int idAdmin) async {
    return await sl<GroupService>().addAdmin(idGroup, idAdmin);
  }

  @override
  Future<Group> addMember(int idGroup, int idMember) async {
    return await sl<GroupService>().addMember(idGroup, idMember);
  }

  @override
  Future<Group> createGroup(GroupRequest groupRequest) async {
    return await sl<GroupService>().createGroup(groupRequest);
  }

  @override
  Future<bool> deleteGroup(int id) async {
    return await sl<GroupService>().deleteGroup(id);
  }

  @override
  Future<bool> deleteMember(int idGroup, int idMember) async {
    return await sl<GroupService>().deleteMember(idGroup, idMember);
  }



  @override
  Future<List<User>> listAdmin(int id) async{
    return await sl<GroupService>().listAdmin(id);
  }

  @override
  Future<List<User>> listMember(int id) async{
    return await sl<GroupService>().listMember(id);
  }
  @override
  Future<PageMessage> getMessage(int idGroup, int page, int size) async{
    return await sl<GroupService>().getMessage(idGroup, page, size);
  }

  @override
  Future<PageGroup> seachGroupsByName(String seachGroupsByName, int page, int size) async{
    return await sl<GroupService>().seachGroupsByName(seachGroupsByName, page, size);
  }

  @override
  Future<Connection> getConnection(int idGroup) async {
    return await sl<GroupService>().getConnection(idGroup);
  }



}