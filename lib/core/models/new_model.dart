// To parse this JSON data, do
//
//     final newModel = newModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

NewModel newModelFromJson(String str) => NewModel.fromJson(json.decode(str));

/// Clase que mapea el documento de publicacion de noticias en la app
String newModelToJson(NewModel data) => json.encode(data.toJson());

class NewModel {
    NewModel({
        this.title,
        this.description,
        this.status,
        @required this.imageUrl,
        this.newId,
    });

//    Timestamp createAt;
    String title;
    String description;
//    Timestamp expAt;
    String status;
    String imageUrl;
    String newId;

    factory NewModel.fromJson(Map<String, dynamic> json,[String documentId]) => NewModel(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        status: json["status"] ?? 'A',
        imageUrl: json["image_url"],
        newId: documentId ?? json["new_id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "status": status,
        "image_url": imageUrl,
        "new_id": newId,
    };
}
