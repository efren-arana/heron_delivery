import 'dart:convert';

import 'package:heron_delivery/core/models/location_model.dart';

Shop shopFromJson(String str) => Shop.fromJson(json.decode(str));

String shopToJson(Shop data) => json.encode(data.toJson());

class Shop {
  Shop({
    this.shopId,
    this.imageUrl,
    this.logoUrl,
    this.name,
    this.description,
    this.location,
    this.voteAverage,
    this.categories,
    this.telefono,
    this.direction,
    this.status,
  });

  String shopId;
  String imageUrl;
  String logoUrl;
  String name;
  String description;
  LocationModel location;
  List<String> categories;
  String telefono;
  Direction direction;
  String status;
  double voteAverage;

  factory Shop.fromJson(Map<String, dynamic> json, [String documentId = '']) =>
      Shop(
        shopId: documentId,
        voteAverage:  json["vote_average"],
        imageUrl: json["image_url"],
        logoUrl: json["logo_url"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        telefono: json["telefono"],
        direction: Direction.fromJson(json["shop_address"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "logo_url": logoUrl,
        "name": name,
        "description": description,
        "location": location,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "telefono": telefono,
        "direction": direction.toJson(),
        "status": status,
      };
}

class Direction {
  Direction(
      {this.calleSecundaria,
      this.callePrincipal,
      this.referencia,
      this.ciudad});

  String calleSecundaria;
  String callePrincipal;
  String referencia;
  String ciudad;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
      calleSecundaria: json["secundary_street"],
      callePrincipal: json["main_street"],
      referencia: json["reference"],
      ciudad: json["city"]);

  Map<String, dynamic> toJson() => {
        "calle secundaria": calleSecundaria,
        "calle principal": callePrincipal,
        "referencia": referencia,
        "ciudad": ciudad
      };
}
