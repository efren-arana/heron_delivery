// To parse this JSON data, do
//
//     final shop = shopFromJson(jsonString);

import 'dart:convert';

Shop shopFromJson(String str) => Shop.fromJson(json.decode(str));

String shopToJson(Shop data) => json.encode(data.toJson());

class Shop {
  Shop({
    this.schedule,
    this.imageUrl,
    this.name,
    this.description,
    this.location,
    this.categories,
    this.telefono,
    this.direction,
    this.status,
  });

  Schedule schedule;
  String imageUrl;
  String name;
  String description;
  Location location;
  List<String> categories;
  int telefono;
  Direction direction;
  String status;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        schedule: Schedule.fromJson(json["schedule"]),
        imageUrl: json["image_url"],
        name: json["name"],
        description: json["description"],
        location: Location.fromJson(json["location"]),
        categories: List<String>.from(json["categories"].map((x) => x)),
        telefono: json["telefono"],
        direction: Direction.fromJson(json["direction"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "schedule": schedule.toJson(),
        "image_url": imageUrl,
        "name": name,
        "description": description,
        "location": location.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "telefono": telefono,
        "direction": direction.toJson(),
        "status": status,
      };
}

class Direction {
  Direction({
    this.calleSecundaria,
    this.callePrincipal,
    this.referencia,
  });

  String calleSecundaria;
  String callePrincipal;
  String referencia;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        calleSecundaria: json["calle secundaria"],
        callePrincipal: json["calle principal"],
        referencia: json["referencia"],
      );

  Map<String, dynamic> toJson() => {
        "calle secundaria": calleSecundaria,
        "calle principal": callePrincipal,
        "referencia": referencia,
      };
}

class Location {
  Location();

  factory Location.fromJson(Map<String, dynamic> json) => Location();

  Map<String, dynamic> toJson() => {};
}

class Schedule {
  Schedule({
    this.martes,
    this.lunes,
  });

  List<String> martes;
  List<String> lunes;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        martes: List<String>.from(json["Martes"].map((x) => x)),
        lunes: List<String>.from(json["Lunes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Martes": List<dynamic>.from(martes.map((x) => x)),
        "Lunes": List<dynamic>.from(lunes.map((x) => x)),
      };
}
