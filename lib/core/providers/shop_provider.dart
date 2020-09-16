import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/core/models/shop_model.dart';
import 'package:heron_delivery/core/services/firestore_service.dart';


class ShopProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService('shops');

  //propiedades controladoras de estado
  String _selectedCategory = 'Todo'; //Todo
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

  void getShopsByCategory(String category) async {
    QuerySnapshot snapshot;

    if (this.categoryShops.containsKey(category)) {
      if (this.categoryShops[category].length > 0) {
        this._isLoading = false;
        notifyListeners();
        return;
      }
    } else {
      this.categoryShops[category] = List();
    }

    //Realizo la peticion
    //por medio de la libreria de flutter de firestore
    if (category.compareTo('Todo') == 0) {
      snapshot = await _firestoreService.getDataCollection();
    } else {
      snapshot = await _firestoreService.getDataCollectionByCategory(
          'categories', this._selectedCategory);
    }
    //print(snapshot.);

    //Obtengo la lista de producto y los almaceno de manera temporal en el mapa
    List<Shop> shops = snapshot.docs.
    map((doc) => Shop.fromJson(doc.data(),doc.id)).
    toList();
//print('==================================Response-Firebase==============================');
      //print(doc.data);
      //print('=================================================================================');

    this.categoryShops[category].addAll(shops);

    this._isLoading = false;
    notifyListeners();
  }
}
