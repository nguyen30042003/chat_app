import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class DeleteGroup implements UseCase<bool, int> {
  @override
  Future<bool> call({int? params}) async {

    return await sl<GroupRepository>().deleteGroup(params!);
  }
}