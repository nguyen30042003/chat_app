import '../../../models/user.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class FindById implements UseCase<User, int> {
  @override
  Future<User> call({int? params}) async {

    return await sl<UserRepository>().findById(params!);
  }
}