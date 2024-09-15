

import '../../models/user.dart';

abstract class GetFriendState{}

class GetFriendLoading extends GetFriendState{}

class GetFriendLoaded extends GetFriendState{
  final List<User> friends;
  GetFriendLoaded({required this.friends});
}

class GetFriendFailure extends GetFriendState{}