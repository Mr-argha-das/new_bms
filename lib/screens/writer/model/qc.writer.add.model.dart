// To parse this JSON data, do
//
//     final qcwritteraddModel = qcwritteraddModelFromJson(jsonString);

import 'dart:convert';

QcwritteraddModel qcwritteraddModelFromJson(String str) => QcwritteraddModel.fromJson(json.decode(str));

String qcwritteraddModelToJson(QcwritteraddModel data) => json.encode(data.toJson());

class QcwritteraddModel {
    String roles;
    String allocationId;
    String name;
    String email;
    String number;
    String password;
    String profile;

    QcwritteraddModel({
        required this.roles,
        required this.allocationId,
        required this.name,
        required this.email,
        required this.number,
        required this.password,
        required this.profile,
    });

    factory QcwritteraddModel.fromJson(Map<String, dynamic> json) => QcwritteraddModel(
        roles: json["roles"],
        allocationId: json["allocationId"],
        name: json["name"],
        email: json["email"],
        number: json["number"],
        password: json["password"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "roles": roles,
        "allocationId": allocationId,
        "name": name,
        "email": email,
        "number": number,
        "password": password,
        "profile": profile,
    };
}
