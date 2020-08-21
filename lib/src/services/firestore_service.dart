import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/src/models/item_model.dart';
import 'package:heron_delivery/src/models/shop_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String path;
  CollectionReference ref;
  
  FirestoreService(this.path) {
    ref = _db.collection(path);
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

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
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
        .doc(product.productId)
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
