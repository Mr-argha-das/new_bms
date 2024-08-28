
//     final teamsUsers = teamsUsersFromJson(jsonString);

import 'dart:convert';

TeamsUsers teamsUsersFromJson(String str) => TeamsUsers.fromJson(json.decode(str));

String teamsUsersToJson(TeamsUsers data) => json.encode(data.toJson());

class TeamsUsers {
    bool status;
    String message;
    Data data;

    TeamsUsers({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TeamsUsers.fromJson(Map<String, dynamic> json) => TeamsUsers(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String teamId;
    String teamName;
    String teamType;
    List<User> users;

    Data({
        required this.teamId,
        required this.teamName,
        required this.teamType,
        required this.users,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        teamId: json["teamId"],
        teamName: json["teamName"],
        teamType: json["teamType"],
        users: List<User>.from(json["Users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "teamId": teamId,
        "teamName": teamName,
        "teamType": teamType,
        "Users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class User {
    String id;
    String name;
    int number;
    String email;
    String? image;
    String roles;

    User({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        this.image,
        required this.roles,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        image: json["image"],
        roles: json["roles"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "email": email,
        "image": image,
        "roles": roles,
    };
}
