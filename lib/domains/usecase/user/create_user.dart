import '../../../models/user.dart';
import '../../../requests/user_request.dart';
import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class CreateUser implements UseCase<User, UserRequest> {
  @override
  Future<User> call({UserRequest? params}) async {

    return await sl<UserRepository>().createUser(params!);
  }
}