import 'dart:async';

import 'package:heron_delivery/core/models/item_category_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/models/new_model.dart';
import 'package:heron_delivery/core/providers/base_model.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/core/services/abst_item_service.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/ui/shared/dialog_manager.dart';
import 'package:rxdart/rxdart.dart';
import '../../locator.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AbstItemService _firestoreServiceItems = locator<AbstItemService>();
  final CartProvider _cartProvider = locator<CartProvider>();

  //TODO: Obtener este valor en la red de un servicio que se encarga de traer todas las congiguraciones
  final double amountMax = 10.0;
  final double amountMin = 2.0;
  //final StreamController<List<ItemModel>> _itemsController =
  //    StreamController<List<ItemModel>>.broadcast();
  final _itemsController = BehaviorSubject<List<ItemModel>>();
  String _selectedCategory = 'Todo'; //Todo

  Stream<List<ItemModel>> get items => _itemsController.stream;

  Future<NewModel> getNews() {
    return _firestoreServiceItems.getNews();
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    if (valor == this.selectedCategory) return;
    this._selectedCategory = valor;
    notifyListeners();
    fetchItemsAsStream(valor);
  }

  void cerrar() async {
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

  /// Metodo que realiza la navegacion al checkout
  Future navigateToCheckoutView() async {
    if (_cartProvider.basketItems.length == 0 ||
        _cartProvider.basketItems == null) return;
    await _navigationService.navigateTo('/checkout');
  }

  /// Metodo que realiza la navegacion a la pagina para realizar la orden
  Future navigateToMakeOrdertView() async {
    if (_cartProvider.basketItems.length == 0 ||
        _cartProvider.basketItems == null) {
      showMyAlertDialog('Fallo Pedido', 'No hay items en el carrito!');
      return;
    }
    if (_cartProvider.granTotal > amountMax) {
      showMyAlertDialog(
          'Fallo Pedido',
          'El monto maximo de su pedido no debe superar los ' +
              '\$' +
              amountMax.toString());
      return;
    }

    if(_cartProvider.granTotal < amountMin) {
      showMyAlertDialog(
          'Fallo Pedido',
          'El monto minimo de su pedido debe superar los ' +
              '\$' +
              amountMin.toString());
      return;
    }

    await _navigationService.navigateTo('/make_order');
  }
}
