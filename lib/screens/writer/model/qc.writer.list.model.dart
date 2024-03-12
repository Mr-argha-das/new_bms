// To parse this JSON data, do
//
//     final qcwritterListModel = qcwritterListModelFromJson(jsonString);

import 'dart:convert';

QcwritterListModel qcwritterListModelFromJson(String str) => QcwritterListModel.fromJson(json.decode(str));

String qcwritterListModelToJson(QcwritterListModel data) => json.encode(data.toJson());

class QcwritterListModel {
    bool status;
    String message;
    List<Datum> data;

    QcwritterListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory QcwritterListModel.fromJson(Map<String, dynamic> json) => QcwritterListModel(
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
    String profile;
    bool isDelete;
    bool isVerify;
    bool status;
    String roles;
    String allocationId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
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
        profile: json["profile"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        status: json["status"],
        roles: json["roles"],
        allocationId: json["allocationId"],
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
        "profile": profile,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "status": status,
        "roles": roles,
        "allocationId": allocationId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
