import 'package:chat_project/models/relationship.dart';

import '../../../service_locator.dart';
import '../../../utils/use_case.dart';
import '../../repository/user_repository.dart';

class GetRelationship implements UseCase<Relationship, Map<String, int>> {
  @override
  Future<Relationship> call({Map<String, int>? params}) async {
    return await sl<UserRepository>().getRelationship(params!['id1']!, params!['id2']!);
  }
}
