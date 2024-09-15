import 'package:chat_project/models/group.dart';
import 'package:chat_project/models/page_group.dart';
import 'package:chat_project/requests/user_request.dart';
import 'package:chat_project/services/api_service.dart';
import 'package:chat_project/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/page.dart';
import '../models/relationship.dart';
import '../models/user.dart';

class UserServiceImpl implements UserService {
  final ApiService apiService = ApiService();
  final String baseUrl = "http://192.168.1.6:8081/api/v1";

  @override
  Future<User> createUser(UserRequest userRequest) async {
    final String url = '$baseUrl/users';
    final response = await http.post(Uri.parse(url), body: userRequest.toJson());
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> findByUserName(String username) async {
    final String url = '$baseUrl/users/search?username=$username';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> findById(int id) async {
    // final String url = '$baseUrl/users/search?username=$id';
    //
    // final response = await http.get(Uri.parse(url));
    final String url = '/users/$id';
    final response = await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<List<User>> searchByUserName(String username) async {
    final String url = '/users/filter/$username?&page=0&size=10';
    final response =  await apiService.sendRequest(url, 'GET');

    if (response.statusCode == 200) {
      Page page = Page.fromJson(jsonDecode(response.body));
      return  page.users ?? [];
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<Relationship> addFriend(int id1, int id2) async{
    final String url = '/users/$id1/friends/$id2';
    final response =  await apiService.sendRequest(url, 'POST');
    if (response.statusCode == 201) {
      Relationship relationship = Relationship.fromJson(jsonDecode(response.body));
      return  relationship;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<List<User>> listFriend(int id) async{
    final String url = '/users/$id/friends';
    final response =  await apiService.sendRequest(url, 'GET');
    print(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      List<User> users = jsonResponse.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
      return  users;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<bool> deleteFriend(int id1, int id2) async{
    final String url = '/users/$id1/friends/$id2';
    final response =  await apiService.sendRequest(url, 'DELETE');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<List<Group>> listGroup(int id) async{
    final String url = '/users/$id/groups';
    final response =  await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      List<Group> groups = jsonResponse.map((json) => Group.fromJson(json as Map<String, dynamic>)).toList();
      return groups;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<PageGroup> filterGroupsByName(
    int userId,
    String groupName,
    int page,
    int size,
  ) async {
    final String url = '/users/$userId/groups/$groupName?page=$page&size=$size';
    final response = await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      PageGroup pageGroup = PageGroup.fromJson(jsonDecode(response.body));

      return pageGroup;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Future<Relationship> getRelationship(int id1, int id2) async {
    final String url = '/users/$id2/friends/$id1/group-chat';
    final response =  await apiService.sendRequest(url, 'GET');
    if (response.statusCode == 200) {
      Relationship relationship = Relationship.fromJson(jsonDecode(response.body));
      return relationship;
    } else {
      throw Exception('Failed to load user');
    }
  }



}
