import 'package:flutter/cupertino.dart';
import 'package:heron_delivery/src/models/item_model.dart';

class LineItem extends ChangeNotifier {
  Item item;
  int _cantSelected = 0;
  double _total = 0.0;

  LineItem({@required this.item});

  void addItem() {
    _cantSelected++;
    _total = item.price * _cantSelected;
    notifyListeners();
  }

  void removeItem() {
    _cantSelected--;
    _total = item.price * _cantSelected;
    notifyListeners();
  }

  int get stockItem => item.stock;

  double get itemPrice => item.price;

  double get total {
    return _total;
  }

  int get cantSelected => _cantSelected;

}
