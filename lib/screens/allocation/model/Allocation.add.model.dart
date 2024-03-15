// To parse this JSON data, do
//
//     final allocationAddModel = allocationAddModelFromJson(jsonString);

import 'dart:convert';

AllocationAddModel allocationAddModelFromJson(String str) => AllocationAddModel.fromJson(json.decode(str));

String allocationAddModelToJson(AllocationAddModel data) => json.encode(data.toJson());

class AllocationAddModel {
    String name;
    String email;
    String number;
    String password;
    String profilePic;

    AllocationAddModel({
        required this.name,
        required this.email,
        required this.number,
        required this.password,
        required this.profilePic,
    });

    factory AllocationAddModel.fromJson(Map<String, dynamic> json) => AllocationAddModel(
        name: json["name"],
        email: json["email"],
        number: json["number"],
        password: json["password"],
        profilePic: json["ProfilePic"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "number": number,
        "password": password,
        "ProfilePic": profilePic,
    };
}

// To parse this JSON data, do
//
//     final allocationAddModel = allocationAddModelFromJson(jsonString);

class AllocationUpdateModel {
    String name;
    String email;
    String number;


    AllocationUpdateModel({
        required this.name,
        required this.email,
        required this.number,
    });

    factory AllocationUpdateModel.fromJson(Map<String, dynamic> json) => AllocationUpdateModel(
        name: json["name"],
        email: json["email"],
        number: json["number"],


    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "number": number,
    };
}
