
import '../../../models/page_group.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class SearchGroupsByName implements UseCase<PageGroup, Map<String, dynamic>> {
  @override
  Future<PageGroup> call({Map<String, dynamic>? params}) async {
    return await sl<GroupRepository>().seachGroupsByName(
      params!['groupName'],
      params!['page'],
      params!['size'],
    );
  }
}