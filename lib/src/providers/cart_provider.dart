import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/item_model.dart';

class Cart extends ChangeNotifier {
  List<Item> _items = [];
  double _totalPrice = 0.0;

  void add(Item item) {
    _items.add(item);
    _totalPrice += item.price;
    notifyListeners();
  }

  void remove(Item item) {
    _totalPrice -= item.price;
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Item> get basketItems {
    return _items;
  }
}
