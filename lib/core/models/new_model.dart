// To parse this JSON data, do
//
//     final newModel = newModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

NewModel newModelFromJson(String str) => NewModel.fromJson(json.decode(str));

String newModelToJson(NewModel data) => json.encode(data.toJson());

class NewModel {
    NewModel({
        this.createAt,
        this.title,
        this.description,
        this.expAt,
        this.status,
        @required this.imageUrl,
        this.newId,
    });

    Timestamp createAt;
    String title;
    String description;
    Timestamp expAt;
    String status;
    String imageUrl;
    String newId;

    factory NewModel.fromJson(Map<String, dynamic> json,[String documentId]) => NewModel(
        createAt: json["create_at"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        expAt: json["exp_at"],
        status: json["status"] ?? 'A',
        imageUrl: json["image_url"],
        newId: documentId ?? json["new_id"],
    );

    Map<String, dynamic> toJson() => {
        "create_at": createAt,
        "title": title,
        "description": description,
        "exp_at": expAt,
        "status": status,
        "image_url": imageUrl,
        "new_id": newId,
    };
}
