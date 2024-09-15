import 'package:chat_project/models/connection.dart';

import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/group_repository.dart';

class GetConnection implements UseCase<Connection, int> {
  @override
  Future<Connection> call({int? params}) async {
    return await sl<GroupRepository>().getConnection(params!);
  }


}