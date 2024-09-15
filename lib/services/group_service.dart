import 'package:chat_project/models/relationship.dart';

import '../models/connection.dart';
import '../models/group.dart';
import '../models/message.dart';
import '../models/page_group.dart';
import '../models/user.dart';
import '../requests/group_request.dart';

abstract class GroupService {
  Future<Group> createGroup(GroupRequest groupRequest);
  Future<Group> addMember(int idGroup, int idMember);
  Future<Group> addAdmin(int idGroup, int idAdmin);
  Future<List<User>> listMember(int id);
  Future<List<User>> listAdmin(int id);
  Future<Connection> getConnection(int idGroup);
  Future<PageGroup> seachGroupsByName(
    String groupName,
    int page ,
    int size,
  );
  Future<bool> deleteGroup(int id);
  Future<bool> deleteMember(int idGroup, int idMember);
  Future<PageMessage> getMessage(
    int idGroup,
    int page,
    int size,
  );
}