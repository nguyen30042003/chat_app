import 'package:chat_project/domains/repository/user_repository.dart';
import 'package:chat_project/models/group.dart';
import 'package:chat_project/models/page_group.dart';
import 'package:chat_project/models/relationship.dart';
import 'package:chat_project/models/user.dart';
import 'package:chat_project/requests/user_request.dart';
import 'package:chat_project/services/user_service.dart';

import '../../service_locator.dart';

class UserRepositoryImpl extends UserRepository{
  @override
  Future<Relationship> addFriend(int id1, int id2) async{
    return await sl<UserService>().addFriend(id1, id2);
  }

  @override
  Future<User> createUser(UserRequest userRequest) async{
    return await sl<UserService>().createUser(userRequest);
  }

  @override
  Future<bool> deleteFriend(int id1, int id2) async{
    return await sl<UserService>().deleteFriend(id1, id2);
  }

  @override
  Future<PageGroup> filterGroupsByName(int userId, String groupName, int page, int size) async{
    return await sl<UserService>().filterGroupsByName(userId, groupName, page, size);
  }

  @override
  Future<User> findById(int id) async{
    return await sl<UserService>().findById(id);
  }

  @override
  Future<User> findByUserName(String username) async{
    return await sl<UserService>().findByUserName(username);
  }

  @override
  Future<List<User>> listFriend(int id) async{
    return await sl<UserService>().listFriend(id);
  }

  @override
  Future<List<Group>> listGroup(int id) async{
    return await sl<UserService>().listGroup(id);
  }

  @override
  Future<List<User>> searchByUserName(String username) async{
    return await sl<UserService>().searchByUserName(username);
  }

  @override
  Future<Relationship> getRelationship(int id1, int id2) async {
    return await sl<UserService>().getRelationship(id1, id2);
  }

}