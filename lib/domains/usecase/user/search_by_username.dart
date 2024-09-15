import '../../../models/user.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class SearchByUserName implements UseCase<List<User>, String> {
  @override
  Future<List<User>> call({String? params}) async {
    return await sl<UserRepository>().searchByUserName(params!);
  }
}