// To parse this JSON data, do
//
//     final itemCategoryModel = itemCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

ItemCategoryModel itemCategoryModelFromJson(String str) => ItemCategoryModel.fromJson(json.decode(str));

String itemCategoryModelToJson(ItemCategoryModel data) => json.encode(data.toJson());

class ItemCategoryModel {
    ItemCategoryModel({
        this.description,
        this.imageUrl,
        @required this.name,
        this.status,
        @required this.itemCategoryId,
    });

    String description;
    String imageUrl;
    String name;
    String status;
    String itemCategoryId;

    factory ItemCategoryModel.fromJson(Map<String, dynamic> json,[String documentId]) => ItemCategoryModel(
        description: json["description"] ?? '',
        imageUrl: json["image_url"] ?? '',
        name: json["name"],
        status: json["status"] ?? 'A',
        itemCategoryId: documentId ?? json["item_category_id"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "image_url": imageUrl,
        "name": name,
        "status": status,
        "item_category_id": itemCategoryId,
    };
}
