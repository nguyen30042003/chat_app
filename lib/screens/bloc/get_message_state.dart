



import 'package:chat_project/models/message.dart';

abstract class GetMessageState{}

class GetMessageLoading extends GetMessageState{}

class GetMessageLoaded extends GetMessageState{
  final PageMessage pageMessage;
  GetMessageLoaded({required this.pageMessage});
}

class GetMessageFailure extends GetMessageState{}