import '../models/group.dart';
import '../models/page_group.dart';
import '../models/relationship.dart';
import '../models/user.dart';
import '../requests/user_request.dart';

abstract class UserService {
  Future<User> createUser(UserRequest userRequest);
  Future<User> findByUserName(String username);
  Future<User> findById(int id);
  Future<List<User>> searchByUserName(String username);
  Future<Relationship> addFriend(int id1, int id2);
  Future<List<User>> listFriend(int id);
  Future<bool> deleteFriend(int id1, int id2);
  Future<List<Group>> listGroup(int id);
  Future<Relationship> getRelationship(int id1, int id2);
  Future<PageGroup> filterGroupsByName(
    int userId,
    String groupName,
    int page,
    int size,
  );
}