


import 'package:chat_project/models/group.dart';

abstract class GetGroupState{}

class GetGroupLoading extends GetGroupState{}

class GetGroupLoaded extends GetGroupState{
  final List<Group> groups;
  GetGroupLoaded({required this.groups});
}

class GetGroupFailure extends GetGroupState{}