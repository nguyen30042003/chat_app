import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class DeleteFriend implements UseCase<bool, Map<int, int>> {
  @override
  Future<bool> call({Map<int, int>? params}) async {

    return await sl<UserRepository>().deleteFriend(params!['id1']!, params!['id2']!);
  }
}