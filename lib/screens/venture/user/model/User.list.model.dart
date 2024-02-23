// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
    bool status;
    String message;
    List<Datum> data;

    UserListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
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
    String image;
    bool isDelete;
    bool isVerify;
    bool status;
    Roles? roles;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String? teams;

    Datum({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.image,
        required this.isDelete,
        required this.isVerify,
        required this.status,
        required this.roles,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        this.teams,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        status: json["status"],
        roles: json["roles"] == null ? null : Roles.fromJson(json["roles"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        teams: json["teams"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "email": email,
        "password": password,
        "image": image,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "status": status,
        "roles": roles?.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "teams": teams,
    };
}

class Roles {
    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Roles({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
