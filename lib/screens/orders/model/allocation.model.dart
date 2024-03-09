// To parse this JSON data, do
//
//     final allocationListmodel = allocationListmodelFromJson(jsonString);

import 'dart:convert';

AllocationListmodel allocationListmodelFromJson(String str) => AllocationListmodel.fromJson(json.decode(str));

String allocationListmodelToJson(AllocationListmodel data) => json.encode(data.toJson());

class AllocationListmodel {
    bool status;
    String message;
    List<Datum> data;

    AllocationListmodel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AllocationListmodel.fromJson(Map<String, dynamic> json) => AllocationListmodel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String name;
    int number;
    String email;
    String password;
    String profilePic;
    bool isDelete;
    bool isVerify;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.profilePic,
        required this.isDelete,
        required this.isVerify,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        profilePic: json["ProfilePic"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "email": email,
        "password": password,
        "ProfilePic": profilePic,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
