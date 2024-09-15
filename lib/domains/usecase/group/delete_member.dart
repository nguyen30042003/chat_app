import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class DeleteMember implements UseCase<bool, Map<int, int>> {
  @override
  Future<bool> call({Map<int, int>? params}) async {

    return await sl<GroupRepository>().deleteMember(params!['idGroup']!, params!['idMember']!);
  }
}