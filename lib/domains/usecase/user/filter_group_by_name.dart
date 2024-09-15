import '../../../models/page_group.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class FilterGroupsByName implements UseCase<PageGroup, Map<int, dynamic>> {
  @override
  Future<PageGroup> call({Map<int, dynamic>? params}) async {

    return await sl<UserRepository>().filterGroupsByName(
      params!['userId'],
      params!['groupName'],
      params!['page'],
      params!['size'],
    );
  }
}