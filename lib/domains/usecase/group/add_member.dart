import '../../../models/group.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class AddMember implements UseCase<Group, Map<int, int>> {
  @override
  Future<Group> call({Map<int, int>? params}) async {
    return await sl<GroupRepository>().addMember(params!["idGroup"]!, params!['idMember']!);
  }
}