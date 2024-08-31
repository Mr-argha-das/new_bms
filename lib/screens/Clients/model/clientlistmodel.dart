// To parse this JSON data, do
//
//     final clientListModel = clientListModelFromJson(jsonString);

import 'dart:convert';

ClientListModel clientListModelFromJson(String str) => ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) => json.encode(data.toJson());

class ClientListModel {
    bool status;
    String message;
    List<Datum> data;

    ClientListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ClientListModel.fromJson(Map<String, dynamic> json) => ClientListModel(
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
    bool isDelete;
    bool status;
    bool isVerify;
    String university;
    String countryCode;
    String createdBy;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.isDelete,
        required this.status,
        required this.isVerify,
        required this.university,
        required this.countryCode,
        required this.createdBy,
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
        isDelete: json["is_delete"],
        status: json["status"],
        isVerify: json["isVerify"],
        university: json["university"],
        countryCode: json["countryCode"],
        createdBy: json["createdBy"],
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
        "is_delete": isDelete,
        "status": status,
        "isVerify": isVerify,
        "university": university,
        "countryCode": countryCode,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
