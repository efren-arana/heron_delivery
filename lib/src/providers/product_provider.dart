import 'package:heron_delivery/src/models/product_model.dart';
import 'package:heron_delivery/src/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

export 'package:heron_delivery/src/models/product_model.dart';

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

  loadValues(Product product) {
    _name = product.name;
    _price = product.price;
    _productId = product.productId;
  }

  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Product(name: name, price: price, productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct =
          Product(name: name, price: _price, productId: _productId);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
