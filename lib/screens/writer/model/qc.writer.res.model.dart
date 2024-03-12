// To parse this JSON data, do
//
//     final qcwritterResModel = qcwritterResModelFromJson(jsonString);

import 'dart:convert';

QcwritterResModel qcwritterResModelFromJson(String str) => QcwritterResModel.fromJson(json.decode(str));

String qcwritterResModelToJson(QcwritterResModel data) => json.encode(data.toJson());

class QcwritterResModel {
    bool status;
    String message;
    Data? data;

    QcwritterResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory QcwritterResModel.fromJson(Map<String, dynamic> json) => QcwritterResModel(
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
    String profile;
    bool isDelete;
    bool isVerify;
    bool status;
    String roles;
    String allocationId;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.profile,
        required this.isDelete,
        required this.isVerify,
        required this.status,
        required this.roles,
        required this.allocationId,
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
        profile: json["profile"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        status: json["status"],
        roles: json["roles"],
        allocationId: json["allocationId"],
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
        "profile": profile,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "status": status,
        "roles": roles,
        "allocationId": allocationId,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
