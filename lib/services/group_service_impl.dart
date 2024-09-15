
import 'dart:convert';

import 'package:chat_project/models/connection.dart';
import 'package:chat_project/models/group.dart';
import 'package:chat_project/models/message.dart';
import 'package:chat_project/models/relationship.dart';
import 'package:chat_project/requests/group_request.dart';
import 'package:chat_project/services/group_service.dart';

import '../models/page_group.dart';
import '../models/user.dart';
import 'api_service.dart';

class GroupServiceImpl implements GroupService{
  final ApiService apiService = ApiService();
  @override
  Future<Group> createGroup(GroupRequest groupRequest) async {
    String url = '/groups';
    final response = await apiService.sendRequest(url, 'POST',  body: groupRequest.toJson());
    if (response.statusCode == 201) {
      return Group.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
  @override
  Future<Group> addMember(int idGroup, int idMember) async{
    final String url = '/groups/$idGroup/members/$idMember';
    final response = await apiService.sendRequest(url, 'POST');
    if (response.statusCode == 202) {
      return Group.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
  @override
  Future<Group> addAdmin(int idGroup, int idAdmin) async{
    final String url = '/groups/$idGroup/admins/$idAdmin';
    final response = await apiService.sendRequest(url, 'POST');
    if (response.statusCode == 202) {
      return Group.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<List<User>> listMember(int id) async{
    final String url = '/groups/$id/members';
    final response =  await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;

      List<User> users = jsonResponse.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();

      return  users;
    } else {
      throw Exception('Failed to load user');
    }
  }
  @override
  Future<List<User>> listAdmin(int id) async{
    final String url = '/groups/$id/admins';
    final response =  await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;

      List<User> users = jsonResponse.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();

      return  users;
    } else {
      throw Exception('Failed to lorequired ad user');
    }
  }
  @override
  Future<PageGroup> seachGroupsByName(
      String groupName,
      int page,
      int size,
      ) async {
    final String url = '/groups/search/$groupName?page=$page&size=$size';

    final response = await apiService.sendRequest(url, 'GET');

    // Check if the response status is OK
    if (response.statusCode == 200) {
      PageGroup pageGroup = PageGroup.fromJson(jsonDecode(response.body));

      return pageGroup;
    } else {
      throw Exception('Failed to load groups');
    }
  }
  @override
  Future<bool> deleteGroup(int id) async {
    String url = '/groups';
    final response = await apiService.sendRequest(url, 'DELETE');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load user');
    }
  }
  @override
  Future<bool> deleteMember(int idGroup, int idMember) async {
    String url = '/groups/$idGroup/members/$idMember';
    final response = await apiService.sendRequest(url, 'DELETE');
    if (response.statusCode == 202) {
      return true;
    } else {
      throw Exception('Failed to load user');
    }
  }
  @override
  Future<PageMessage> getMessage(
    int idGroup,
    int page,
    int size,
  ) async {
    final String url = '/groups/$idGroup/messages?page=$page&size=$size';

    final response = await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      PageMessage pageMessage = PageMessage.fromJson(jsonDecode(response.body));
      return pageMessage;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Future<Connection> getConnection(int idGroup) async {
    String url = '/groups/$idGroup/connection';
    final response = await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      return Connection.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

}