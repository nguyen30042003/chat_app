import '../../../models/user.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class ListAdmin implements UseCase<List<User>, int> {
  @override
  Future<List<User>> call({int? params}) async {
    return await sl<GroupRepository>().listAdmin(params!);
  }
}