import 'package:flutter/cupertino.dart';
import 'package:heron_delivery/core/models/item_model.dart';

class LineItemModel {
  ItemModel item;
  int cantSelected = 1;
  double _total = 0.0;
  LineItemModel({@required this.item});

  set setItem(ItemModel item) {
    this.item = item;
    _total = this.item.unitPriceSale * cantSelected;
  }

  //set total(double value) => _total = value;

  void addItem() {
    cantSelected++;
    _total = this.item.unitPriceSale * cantSelected;
  }

  void removeItem() {
    cantSelected--;
    _total = this.item.unitPriceSale * cantSelected;
  }

  double get total =>
      (_total == 0.0) ? (this.item.unitPriceSale * cantSelected) : _total;
}
