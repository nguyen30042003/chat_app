import '../../../models/user.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class ListFriend implements UseCase<List<User>, int> {
  @override
  Future<List<User>> call({int? params}) async {
    return await sl<UserRepository>().listFriend(params!);
  }
}