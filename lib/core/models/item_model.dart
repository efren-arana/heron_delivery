// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    @required this.unitPriceSale,
    @required this.itemId,
    @required this.imageUrl,
    this.unitPricePurchase,
    @required this.available,
    @required this.description,
    @required this.name,
    @required this.categories,
    @required this.unitsInStock,
    this.unitsOnOrder = 0,
    this.quantXUnit = 1,
    this.supplierId = '',
    this.barcode = '',
    @required this.status,
  });

  double unitPriceSale;
  String itemId;
  String imageUrl;
  int unitPricePurchase;
  bool available;
  String description;
  String name;
  List<String> categories;
  int unitsInStock;
  int unitsOnOrder;
  int quantXUnit;
  String supplierId;
  String barcode;
  String status;

  ///Contructor con nombre que recibe un parametro posicional opcional
  factory ItemModel.fromJson(Map<String, dynamic> json, [String documentId]) =>
      ItemModel(
        unitPriceSale: json["unit_price_sale"].toDouble(),
        itemId: documentId ?? json["item_id"],
        imageUrl: json["image_url"],
        unitPricePurchase: json["unit_price_purchase"] ?? 0,
        available: json["available"],
        description: json["description"],
        name: json["name"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        unitsInStock: json["units_in_stock"],
        unitsOnOrder: json["units_on_order"] ?? 0,
        quantXUnit: json["quant_x_unit"] ?? 1,
        supplierId: json["supplier_id"] ?? '',
        barcode: json["barcode"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "unit_price_sale": unitPriceSale,
        "item_id": itemId,
        "image_url": imageUrl,
        "unit_price_purchase": unitPricePurchase,
        "available": available,
        "description": description,
        "name": name,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "units_in_stock": unitsInStock,
        "units_on_order": unitsOnOrder,
        "quant_x_unit": quantXUnit,
        "supplier_id": supplierId,
        "barcode": barcode,
        "status": status,
      };

  @override
  bool operator ==(other) {
    return (other is ItemModel) &&
        other.name == this.name &&
        other.description == this.description &&
        other.imageUrl == this.imageUrl &&
        other.available == this.available &&
        other.unitPriceSale == this.unitPriceSale &&
        other.itemId == this.itemId;
  }

  @override
  // TODO: implement hashCode para identificar el objeto
  int get hashCode => super.hashCode;

}
