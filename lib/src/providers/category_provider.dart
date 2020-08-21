import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/src/models/category_model.dart';
import 'package:heron_delivery/src/services/firestore_service.dart';

export 'package:heron_delivery/src/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService('categories');
  List<Category> categories = [];

  Future<List<Category>> fetchCategories() async {
    var result = await _firestoreService.getDataCollection();
    categories = result.docs
        .map((doc) => Category.fromMap(doc.data(), doc.id))
        .toList();
    return categories;
  }

  /// Metodo que obtiene el stream de las categorias que se encuentran activas
  Stream<QuerySnapshot> fetchCategorysAsStream() {
    return _firestoreService.streamDataCollection();
  }

  Future<Category> getProductById(String id) async {
    var doc = await _firestoreService.getDocumentById(id);
    return Category.fromMap(doc.data(), doc.id);
  }
}
