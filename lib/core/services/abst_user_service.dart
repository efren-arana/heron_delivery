

import 'package:heron_delivery/core/models/user_model.dart';

abstract class AbstUserService {
   Future<UserModel> getUserById(String id);

  Future<dynamic> setDocument(String id, Map<String,dynamic> data,[bool merge = false, List<dynamic> fieldPath]);

}