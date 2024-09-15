import '../../../models/group.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class ListGroup implements UseCase<List<Group>, int> {
  @override
  Future<List<Group>> call({int? params}) async {
    return await sl<UserRepository>().listGroup(params!);
  }
}