import 'package:flutter/material.dart';
import 'package:heron_delivery/core/models/item_detail_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/ui/shared/dialog_manager.dart';

class CartProvider extends ChangeNotifier {
  List<LineItemModel> _listItemDetail = [];

  //TODO: Costo de envio de la entrega
  //TODO: este valor se tiene que obtener por medio de una peticion para poder realizar configuraciones
  //TODO: Configurar servicio que se encarga de traer las configuraciones de la app
  double _costDelivery = 0.50;

  /// Disminuye la cantidad de items seleccionado de la linea de item que se envia
  /// como parametro [item] recibe la referencia del item que se encuentra en la lista
  void decreaseQuantityOfItem(LineItemModel lineItemModel) {
    //Disminuyo la cantidad del lineItem que se encuentra en la lista
    if (lineItemModel.cantSelected <= 1) return;
    lineItemModel.removeItem();
    notifyListeners();
  }

  /// Metodo que aumenta la cantidad de un item si se encuentra en la lista
  /// Caso contrario lo agrega a la lista de item del carrito
  void addItemsToList(ItemModel item) {
    LineItemModel lineItemModel = new LineItemModel(item: item);
    _listItemDetail.add(lineItemModel);
    notifyListeners();
  }

  ///MEtodo que incrementa la cantidad del item seleccionado
  void increaseCantOfItems(LineItemModel lineItemModel) {
    if (lineItemModel.cantSelected >= lineItemModel.item.unitsInStock){
      showMyAlertDialog('Fallo Pedido', 'No hay items en el carrito!');
      return;
    }
    lineItemModel.addItem();
    notifyListeners();
  }

  /// Getter que me indica si la canasta se encuentra con items
  bool get itemsInBasket => this.count > 0;
  /// valida si el [itemModel] se encuentra en la lista
  /// Tambien realiza la validacion si la propiedad esta seleccionada
  bool isSelected(ItemModel itemModel) {
    bool isSelected = false;

    _listItemDetail.forEach((element) {
      if (element.item.itemId == itemModel.itemId) {
        isSelected = true;
        if (element.item != itemModel) {
          element.setItem = itemModel;
        }
        return;
      }
    });
    return isSelected;
  }

  /// Quita de la lista el item [item] enviado como parametro
  void removeItemFromList(LineItemModel item) {
    _listItemDetail.remove(item);
    notifyListeners();
  }

  void removeAll() {
    if (_listItemDetail.length == 0) return;
    _listItemDetail.clear();
    notifyListeners();
  }

  /// Obtiene la cantidad de items seleccionados
  int get count {
    int cant = 0;
    _listItemDetail.forEach((element) {
      cant += element.cantSelected;
    });
    return cant;
  }

  /// The current total price of all items
  double get subTotal {
    double subTotal = 0.0;
    _listItemDetail.forEach((element) {
      subTotal += element.total;
    });

    return subTotal;
  }

  double get granTotal {
    double granTotal = 0.0;
    granTotal = subTotal + costDelivery;
    return granTotal;
  }

  double get costDelivery {
    return this._costDelivery;
  }

  /// Retorna la lista de items
  List<LineItemModel> get basketItems {
    return _listItemDetail;
  }
}
