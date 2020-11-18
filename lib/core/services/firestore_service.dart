import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  FirestoreService(this.path) {
    ref = _db.collection(path);
  }

  
  Future setDocument(String id, Map data) async {
    //TODO: Agregar setOption para combinar los datos en lugar de sobreescribirlos
    try {
      await ref.doc(id).set(data);
      return true;
    } catch (e) {
      return e.message;
    }
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    try {
      return ref.doc(id).get();
    } catch (e) {
      return e.message;
    }
  }

  //=========================Flutter — Firebase FireStore CRUD Operations Using Provider========

  Future<QuerySnapshot> getDataCollection() {
    try {
      return ref.get();
    } catch (e) {
      return e.message;
    }
    
  }

  /// Obtengo los documetnso de la conleccion
  /// Filtrando por categoria
  /// el parametro filter es la categoria
  /// se filta usando el arrayContains
  Future<QuerySnapshot> getDataCollectionByCategory(
      dynamic field, dynamic filter) {
    return ref.where(field, arrayContains: filter).get();
  }

  /// Stream de la coleccion instanciada
  /// Obtiene un stream donde el documento este activo
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.where('status', isEqualTo: "A")
    .snapshots();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
  //==============================================================================================

}
