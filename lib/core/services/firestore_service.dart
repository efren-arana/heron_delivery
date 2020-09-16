import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/core/models/item_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;
  
  FirestoreService(this.path) {
    ref = _db.
    collection(path);
  }

  //Metodo que registra un documento en la coleccion
  // estableciendo un id
  Future setDocument(String id,Map data) async {
    try {
      await ref.doc(id).set(data);
    } catch (e) {
      return e.message;
    }
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  //=========================Flutter — Firebase FireStore CRUD Operations Using Provider========

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  /// Obtengo los documetnso de la conleccion
  /// Filtrando por categoria
  /// el parametro filter es la categoria
  /// se filta usando el arrayContrains
  Future<QuerySnapshot> getDataCollectionByCategory(dynamic field,dynamic filter) {
    return ref.where(field,arrayContains: filter).get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.where('status',isEqualTo: "A").snapshots();
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

  Future<void> saveProduct(Item product) {
    return _db
        .collection('products')
        .doc(product.idItem)
        .set(product.toMap());
  }

  Stream<List<Item>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Item.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }
}
