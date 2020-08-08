import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/src/models/product_model.dart';
import 'package:heron_delivery/src/models/shop_model.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  final String path;
  CollectionReference ref;
  
  FirestoreService(this.path) {
    ref = _db.collection(path);
  }

  //=========================Flutter — Firebase FireStore CRUD Operations Using Provider========

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  /// Obtengo los documetnso de la conleccion
  /// Filtrando por categoria
  /// el parametro filter es la categoria
  /// se filta usando el arrayContrains
  Future<QuerySnapshot> getDataCollectionByCategory(dynamic field,dynamic filter) {
    return ref.where(field,arrayContains: filter).getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.where('status',isEqualTo: "A").snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
  //==============================================================================================

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .document(product.productId)
        .setData(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Product.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').document(productId).delete();
  }
}
