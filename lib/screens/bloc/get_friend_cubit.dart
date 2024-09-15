import 'package:chat_project/domains/usecase/user/list_friend.dart';
import 'package:chat_project/screens/bloc/get_friend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service_locator.dart';
import '../../../models/user.dart';

class GetFriendCubit extends Cubit<GetFriendState> {
  GetFriendCubit() : super(GetFriendLoading());

  Future<void> getFriend() async {
    emit(GetFriendLoading()); // Đảm bảo trạng thái loading được emit trước
    final prefs = await SharedPreferences.getInstance();
    int userId =  prefs.getInt('userId') ?? 10; // Replace with actual user ID as needed

    try {
      // Call use case directly, assuming it returns Future<List<User>>
      List<User> friends = await sl<ListFriend>().call(params: userId);

      if (friends.isNotEmpty) {
        emit(GetFriendLoaded(friends: friends));
      } else {
        emit(GetFriendFailure());
      }
    } catch (e) {
      // Xử lý khi có exception xảy ra
      emit(GetFriendFailure());
    }
  }
}
