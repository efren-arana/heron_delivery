import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/src/models/category_model.dart';
import 'package:heron_delivery/src/models/news_models.dart';
import 'package:heron_delivery/src/models/shop_model.dart';
import 'package:heron_delivery/src/services/firestore_service.dart';

export 'package:heron_delivery/src/models/category_model.dart';

class ShopProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService('shops');

  String _selectedCategory = 'AkBXtncUtRfzaBpra9zv'; //Todo
  bool _isLoading = true;
  //mapa que almacena la lista de las tiendas por categoria.
  Map<String, List<Shop>> categoryShops = {};

  ShopProvider() {
    //  this.getTopHeadlines();

    this.categoryShops[this._selectedCategory] = new List();

    this.getShopsByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getShopsByCategory(valor);
    notifyListeners();
  }

  List<Shop> get getShopCategoriaSeleted =>
      this.categoryShops[this.selectedCategory];

  getShopsByCategory(String category) async {
    if (this.categoryShops[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryShops[category];
    }
    //DocumentSnapshot

    DocumentSnapshot snapshot =
        await _firestoreService.getDocumentById('AkBXtncUtRfzaBpra9zv');
    print(snapshot.data);

    //List<Shop> shop =
    //    snapshot.documents.map((doc) => Shop.fromJson(doc.data)).toList();

    //this.categoryShops[category].addAll(shop);

    this._isLoading = false;
    notifyListeners();
  }

  Stream<List<Shop>> fetchShopsAsStream() {
    return _firestoreService.streamDataCollection().map((snapshot) => snapshot
        .documents
        .map((document) => Shop.fromJson(document.data))
        .toList());
  }
}
