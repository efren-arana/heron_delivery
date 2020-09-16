import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String name;
  String id;
  String price;
  String img;

  Category(this.icon, this.name);

  Category.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '',
        icon = null;

  toJson() {
    return {
      "price": price,
      "name": name,
      "img": img,
    };
  }
}
