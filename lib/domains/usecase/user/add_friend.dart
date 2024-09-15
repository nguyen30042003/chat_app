import '../../../models/relationship.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class AddFriend implements UseCase<Relationship, Map<int, int>> {
  @override
  Future<Relationship> call({Map<int, int>? params}) async {
    return await sl<UserRepository>().addFriend(params!['id1']!, params!['id2']!);
  }
}