// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {@required this.email,
      @required this.fullName,
      this.password = '',
      @required this.userId,
      this.phoneNumber = '',
      this.photoUrl = '',
      this.userAddress,
      this.userLocation,
      this.userRolId = '',
      this.userRolRef,
      this.status = 'A'});

  String status;
  String email;
  String fullName;
  String phoneNumber;
  String photoUrl;
  UserAddress userAddress;
  String userId;
  GeoPoint userLocation;
  String userRolId;
  DocumentReference userRolRef;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json["email"],
      password: json["password"],
      fullName: json["full_name"],
      phoneNumber: json["phone_number"] ?? '',
      photoUrl: json["photo_url"] ?? '',
      userAddress: (json["user_address"] != null)
          ? UserAddress.fromJson(json["user_address"])
          : null,
      userId: json["user_id"],
      userLocation: json["user_location"],
      userRolId: json["user_rol_id"] ?? '',
      userRolRef: json["user_rol_ref"],
      status: json['status'] ?? 'A');

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "photo_url": photoUrl,
        "user_address": (userAddress != null) ? (userAddress.toJson()) : null,
        "user_id": userId,
        "user_location": userLocation,
        "user_rol_id": userRolId,
        "user_rol_ref": userRolRef,
        "status": status
      };
}

class UserAddress {
  UserAddress({
    this.city,
    this.mainStreet,
    this.secondaryStreet,
    this.reference,
  });

  String city;
  String mainStreet;
  String secondaryStreet;
  String reference;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        city: json["city"],
        mainStreet: json["main_street"],
        secondaryStreet: json["secondary_street"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "main_street": mainStreet,
        "secondary_street": secondaryStreet,
        "reference": reference,
      };
}
