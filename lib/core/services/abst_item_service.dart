import 'package:heron_delivery/core/models/item_category_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';

abstract class AbstItemService {
  Future<ItemModel> getItemById(String id);

  Future<dynamic> setItem(String id, Map data);

  Stream<List<ItemModel>> streamOfItems();

  Stream<List<ItemCategoryModel>> streamOfCategories();
}
