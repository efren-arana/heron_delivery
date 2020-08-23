import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/item_detail_model.dart';
import 'package:heron_delivery/src/models/item_model.dart';

class Cart extends ChangeNotifier {
  List<LineItem> _items = [];
  double _totalPrice = 0.0;


  double total(LineItem item) {
    return item.total;
  }

  void addItem(LineItem item) {
    item.addItem();
    notifyListeners();
  }

  void removeItem(LineItem item) {
    if (item.cantSelected <= 1) return;
    item.removeItem();
    notifyListeners();
  }

  void add(LineItem item) {
    /*
    _items.forEach((element) {
      if (element.hashCode == item.hashCode) {
        if (element.selected) {
          print('${item.itemName} seleted');
          if (element.total != item.total) {
            element.total = item.total;
          }
        }
        return;
      }
    });
    */
    if (item.selected) return;

    item.selected = true;
    _items.add(item);
    notifyListeners();
  }

  void remove(LineItem item) {
    _totalPrice -= item.total;
    item.selected = false;
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _totalPrice = 0.0;
    _items.forEach((element) {
      element.selected = false;
    });
    _items.clear();
    notifyListeners();
  }

  int get count {
    int cant = 0;
    _items.forEach((element) {
      cant += element.cantSelected;
    });
    return cant;
  }

  double get totalPrice {
    return _totalPrice;
  }

  double get subTotal {
    double subTotal = 0.0;
    _items.forEach((element) {
      subTotal += element.total;
    });

    return subTotal;
  }

  List<LineItem> get basketItems {
    return _items;
  }
}
