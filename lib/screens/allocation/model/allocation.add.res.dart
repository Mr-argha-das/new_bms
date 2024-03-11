// To parse this JSON data, do
//
//     final allocationAddResponse = allocationAddResponseFromJson(jsonString);

import 'dart:convert';

AllocationAddResponse allocationAddResponseFromJson(String str) => AllocationAddResponse.fromJson(json.decode(str));

String allocationAddResponseToJson(AllocationAddResponse data) => json.encode(data.toJson());

class AllocationAddResponse {
    bool status;
    String message;
    Data? data;

    AllocationAddResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AllocationAddResponse.fromJson(Map<String, dynamic> json) => AllocationAddResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    String name;
    int number;
    String email;
    String password;
    String profilePic;
    bool isDelete;
    bool isVerify;
    bool status;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.profilePic,
        required this.isDelete,
        required this.isVerify,
        required this.status,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        profilePic: json["ProfilePic"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        status: json["status"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "email": email,
        "password": password,
        "ProfilePic": profilePic,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "status": status,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
