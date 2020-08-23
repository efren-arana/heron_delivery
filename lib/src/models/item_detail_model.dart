import 'package:flutter/cupertino.dart';
import 'package:heron_delivery/src/models/item_model.dart';

class LineItem {
  Item item;
  int _cantSelected = 1;
  double _total = 0.0;
  bool _selected = false;

  LineItem({@required this.item});

  String get idItem => item.idItem;
  String get itemName => item.name;

  bool get selected => _selected;

  set selected(bool selected) {
    this._selected = selected;
  }

  void addItem() {
    _cantSelected++;
    _total = item.price * _cantSelected;
  }

  void removeItem() {
    _cantSelected--;
    _total = item.price * _cantSelected;
  }

  int get stockItem => item.stock;

  double get itemPrice => item.price;

  double get total => (_total == 0.0) ? (item.price * _cantSelected) : _total;
  set total(double value) => _total = value;

  int get cantSelected => _cantSelected;
}
