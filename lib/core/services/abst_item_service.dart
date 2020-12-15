import 'package:heron_delivery/core/models/item_category_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/models/new_model.dart';

abstract class AbstItemService {
  Future<ItemModel> getItemById(String id);

  Future<NewModel> getNews();

  Future<dynamic> setItem(String id, Map data);

  Stream<List<ItemModel>> streamOfItems();

  Stream<List<ItemCategoryModel>> streamOfCategories();
}
