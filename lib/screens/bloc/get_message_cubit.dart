import 'package:chat_project/domains/usecase/group/get_message.dart';
import 'package:chat_project/domains/usecase/user/list_friend.dart';
import 'package:chat_project/models/message.dart';
import 'package:chat_project/screens/bloc/get_friend_state.dart';
import 'package:chat_project/screens/bloc/get_message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service_locator.dart';
import '../../../models/user.dart';

class GetMessageCubit extends Cubit<GetMessageState> {
  final int idGroup;
  late PageMessage pageMessage;

  GetMessageCubit(this.idGroup) : super(GetMessageLoading())
  {
    pageMessage = PageMessage(content: []);
  } // Khởi tạo pageMessage

  void addMessage(Message message) {
    pageMessage.content?.insert(0, message);
    emit(GetMessageLoaded(pageMessage: pageMessage));
  }

  Future<void> getMessage() async {
    emit(GetMessageLoading());
    try {
      Map<String, dynamic> params = {
        'idGroup': idGroup,
        'page': 0,
        'size': 100,
      };
      PageMessage fetchedPageMessage = await sl<GetMessage>().call(params: params);
      print(fetchedPageMessage);
      if (fetchedPageMessage.content!.isNotEmpty) {
        pageMessage.content?.addAll(fetchedPageMessage.content!);
        emit(GetMessageLoaded(pageMessage: pageMessage));
      } else {
        emit(GetMessageFailure());
      }
      } catch (e) {
        emit(GetMessageFailure());
      }
  }
}
