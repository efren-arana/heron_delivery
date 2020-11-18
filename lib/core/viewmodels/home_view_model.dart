import 'dart:async';

import 'package:heron_delivery/core/models/item_category_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/providers/base_model.dart';
import 'package:heron_delivery/core/services/abst_item_service.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../locator.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AbstItemService _firestoreServiceItems = locator<AbstItemService>();

  //final StreamController<List<ItemModel>> _itemsController =
  //    StreamController<List<ItemModel>>.broadcast();
  final _itemsController = BehaviorSubject<List<ItemModel>>();
  String _selectedCategory = 'Todo'; //Todo

  Stream<List<ItemModel>> get items => _itemsController.stream;

  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    if (valor == this.selectedCategory) return;
    this._selectedCategory = valor;
    fetchItemsAsStream(valor);
  }

  void cerrar() async{
    await _itemsController.drain();
    _itemsController?.close();
  }

  /// Stream de las categorias de los productos activas
  Stream<List<ItemCategoryModel>> fetchItemCategoryAsStream() {
    return _firestoreServiceItems.streamOfCategories();
  }

  /// Stream de los productos activas
  void fetchItemsAsStream(String category) {
    List<ItemModel> items;
    //escucho todos el flujo de items y los agregos al stream controller
    _firestoreServiceItems.streamOfItems().listen((event) {
      items = event
          .where((element) => (element.unitsInStock > 0 &&
              element.available &&
              element.status.compareTo('A') == 0))
          .toList();
      if (category.compareTo('Todo') != 0) {
        items = items
            .where((element) => element.categories.contains(category))
            .toList();
      }

      _itemsController.sink.add(items);
    });
  }

  /// Metodo que realiza la navegacion a el detalle del producto
  Future navigateToCreateView() async {
    await _navigationService.navigateTo('ItemDetailView');
  }
}
