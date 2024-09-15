import 'package:chat_project/domains/usecase/user/list_group.dart';
import 'package:chat_project/models/group.dart';
import 'package:chat_project/screens/bloc/get_group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

class GetGroupCubit extends Cubit<GetGroupState>
{
  GetGroupCubit() : super(GetGroupLoading());

  Future<void> getGroup() async {
    final prefs = await SharedPreferences.getInstance();
    int userId =  prefs.getInt('userId') ?? 10;


    try {
      // Call use case directly, assuming it returns Future<List<User>>
      List<Group> groups = await sl<ListGroup>().call(params: userId);

      if (groups.isNotEmpty) {
        emit(GetGroupLoaded(groups: groups));
      } else {
        emit(GetGroupFailure());
      }
    } catch (e) {
      // Xử lý khi có exception xảy ra
      emit(GetGroupFailure());
    }
  }

}