

import 'package:chat_project/domains/repository/auth_repository.dart';
import 'package:chat_project/domains/repository/user_repository.dart';
import 'package:chat_project/domains/repository/user_repository_impl.dart';
import 'package:chat_project/domains/usecase/group/get_connection.dart';
import 'package:chat_project/domains/usecase/group/get_message.dart';
import 'package:chat_project/domains/usecase/login.dart';
import 'package:chat_project/domains/usecase/user/get_relationship.dart';
import 'package:chat_project/domains/usecase/user/list_friend.dart';
import 'package:chat_project/domains/usecase/user/list_group.dart';
import 'package:chat_project/models/connection.dart';
import 'package:chat_project/services/auth_service.dart';
import 'package:chat_project/services/auth_service_impl.dart';
import 'package:chat_project/services/group_service.dart';
import 'package:chat_project/services/group_service_impl.dart';
import 'package:chat_project/services/user_service.dart';
import 'package:chat_project/services/user_service_impl.dart';
import 'package:get_it/get_it.dart';

import 'domains/repository/auth_repository_impl.dart';
import 'domains/repository/group_repository.dart';
import 'domains/repository/group_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  sl.registerLazySingleton<UserService>(() => UserServiceImpl());
  sl.registerLazySingleton<GroupService>(() => GroupServiceImpl());

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  sl.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl());

  // Register use cases as lazy singletons
  sl.registerLazySingleton<Login>(() => Login());
  sl.registerLazySingleton<ListFriend>(() => ListFriend());
  sl.registerLazySingleton<ListGroup>(() => ListGroup());
  sl.registerLazySingleton<GetConnection>(() => GetConnection());
  sl.registerLazySingleton<GetMessage>(() => GetMessage());
  sl.registerLazySingleton<GetRelationship>(() => GetRelationship());
}