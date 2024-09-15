import '../../../models/user.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class FindByUserName implements UseCase<User, String> {
  @override
  Future<User> call({String? params}) async {

    return await sl<UserRepository>().findByUserName(params!);
  }
}