// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
    String id;
    String name;
    String email;
    String rmCode;
    String profilePic;
    bool verify;
    DateTime createdAt;
    List<VentureInfo> ventureInfo;

    UserDetails({
        required this.id,
        required this.name,
        required this.email,
        required this.rmCode,
        required this.profilePic,
        required this.verify,
        required this.createdAt,
        required this.ventureInfo,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        rmCode: json["rmCode"],
        profilePic: json["profilePic"],
        verify: json["Verify"],
        createdAt: DateTime.parse(json["createdAt"]),
        ventureInfo: List<VentureInfo>.from(json["Venture_info"].map((x) => VentureInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "rmCode": rmCode,
        "profilePic": profilePic,
        "Verify": verify,
        "createdAt": createdAt.toIso8601String(),
        "Venture_info": List<dynamic>.from(ventureInfo.map((x) => x.toJson())),
    };
}

class VentureInfo {
    String vId;
    String vName;
    String vType;
    Team team;

    VentureInfo({
        required this.vId,
        required this.vName,
        required this.vType,
        required this.team,
    });

    factory VentureInfo.fromJson(Map<String, dynamic> json) => VentureInfo(
        vId: json["vId"],
        vName: json["vName"],
        vType: json["vType"],
        team: Team.fromJson(json["Team"]),
    );

    Map<String, dynamic> toJson() => {
        "vId": vId,
        "vName": vName,
        "vType": vType,
        "Team": team.toJson(),
    };
}

class Team {
    String id;
    String name;
    String type;

    Team({
        required this.id,
        required this.name,
        required this.type,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["Id"],
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "name": name,
        "type": type,
    };
}
