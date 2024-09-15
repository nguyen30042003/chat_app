import '../../../models/message.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class GetMessage implements UseCase<PageMessage, Map<String, dynamic>> {
  @override
  Future<PageMessage> call({Map<String, dynamic>? params}) async {
    return await sl<GroupRepository>().getMessage(
      params!['idGroup'],
      params!['page'],
      params!['size'],
    );
  }
}