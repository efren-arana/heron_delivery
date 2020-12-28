import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/core/models/user_model.dart';
import 'package:heron_delivery/core/services/abst_user_service.dart';

class UserServiceFirebaseImpl implements AbstUserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path = "users";
  CollectionReference ref;

  UserServiceFirebaseImpl() {
    ref = _db.collection(this.path);
  }
  @override
  Future<UserModel> getUserById(String id) async {
    UserModel response;
    await ref.doc(id).get().then((value) {
      response = UserModel.fromJson(value.data(), value.id);
    });
    return response;
  }

  @override
  Future setDocument(String id, Map<String,dynamic> data,
      [bool merge = false, List<dynamic> fieldPath]) async {
    if (merge) {
      await ref.doc(id).set(data, new SetOptions(merge: true, mergeFields:fieldPath));
    }else{
      await ref.doc(id).set(data);
    }
    
  }
}
