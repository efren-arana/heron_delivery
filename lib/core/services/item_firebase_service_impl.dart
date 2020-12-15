import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/core/models/item_category_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/models/new_model.dart';
import 'package:heron_delivery/core/services/abst_item_service.dart';

class ItemServiceFirebaseImpl implements AbstItemService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String pathItems = "/shops/fn6npNA8Xm4TvuPKB2VE/items";
  final String pathDocNews =
      "/shops/fn6npNA8Xm4TvuPKB2VE/news/PMUznMd4rS05kBm3CSRo";
  CollectionReference ref;

  ItemServiceFirebaseImpl() {
    ref = _db.collection(pathItems);
  }

  @override
  Future<ItemModel> getItemById(String id) async {
    ItemModel response;
    await ref.doc(id).get().then((value) {
      response = ItemModel.fromJson(value.data(), value.id);
    });
    return response;
  }

  @override
  Future<dynamic> setItem(String id, Map data) async {
    //TODO: Agregar setOption para combinar los datos en lugar de sobreescribirlos
    await ref.doc(id).set(data);
  }

  @override
  Stream<List<ItemModel>> streamOfItems() {
    List<ItemModel> items;
    return ref
        .where('status', isEqualTo: "A")
        .snapshots()
        .map<List<ItemModel>>((event) {
      if (event.docs.isNotEmpty) {
        items = event.docs
            .map((snapshot) => ItemModel.fromJson(snapshot.data(), snapshot.id))
            .toList();
      }
      return items;
    });
  }

  @override
  Stream<List<ItemCategoryModel>> streamOfCategories() {
    List<ItemCategoryModel> categories;
    return _db
        .collection('product_category')
        .where('status', isEqualTo: "A")
        .snapshots()
        .map<List<ItemCategoryModel>>((event) {
      if (event.docs.isNotEmpty) {
        categories = event.docs
            .map((snapshot) =>
                ItemCategoryModel.fromJson(snapshot.data(), snapshot.id))
            .toList();
      }
      return categories;
    });
  }

  @override
  Future<NewModel> getNews() async {
    DocumentSnapshot docSnap = await _db.doc(pathDocNews).get();
    return NewModel.fromJson(docSnap.data(),docSnap.id);
  }
}
