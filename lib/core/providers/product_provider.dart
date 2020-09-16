import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService('products');
  String _name;
  double _price;
  String _productId;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get price => _price;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  loadValues(Item product) {
    _name = product.name;
    _price = product.price;
    _productId = product.idItem;
  }

  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Item(name: name, price: price, idItem: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct =
          Item(name: name, price: _price, idItem: _productId);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}