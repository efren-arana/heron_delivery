import 'package:flutter/cupertino.dart';
import 'package:heron_delivery/core/models/item_model.dart';

class LineItem {
  ItemModel item;
  int _cantSelected = 1;
  double _total = 0.0;
  bool _selected = false;
  String comentario = '';
  double peso = 0.0;
  LineItem({@required this.item});

  String get idItem => item.itemId;
  String get itemName => item.name;

  bool get selected => _selected;

  set selected(bool selected) {
    this._selected = selected;
  }

  void addItem() {
    _cantSelected++;
    _total = item.unitPriceSale * _cantSelected;
  }

  void removeItem() {
    _cantSelected--;
    _total = item.unitPriceSale * _cantSelected;
  }

  int get stockItem => item.unitsInStock;

  double get itemPrice => item.unitPriceSale;

  double get total => (_total == 0.0) ? (item.unitPriceSale * _cantSelected) : _total;
  set total(double value) => _total = value;

  int get cantSelected => _cantSelected;
}
