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
  Future setDocument(String id, Map data) async {
    //TODO: Agregar setOption para combinar los datos en lugar de sobreescribirlos
    await ref.doc(id).set(data);
  }
}
