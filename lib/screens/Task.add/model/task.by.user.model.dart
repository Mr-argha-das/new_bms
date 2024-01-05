// To parse this JSON data, do
//
//     final taskByUserModel = taskByUserModelFromJson(jsonString);

import 'dart:convert';

TaskByUserModel taskByUserModelFromJson(String str) => TaskByUserModel.fromJson(json.decode(str));

String taskByUserModelToJson(TaskByUserModel data) => json.encode(data.toJson());

class TaskByUserModel {
    bool status;
    String message;
    List<Datum> data;

    TaskByUserModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskByUserModel.fromJson(Map<String, dynamic> json) => TaskByUserModel(
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
    UserId userId;
    TaskId taskId;
    int points;
    String time;
    String date;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.userId,
        required this.taskId,
        required this.points,
        required this.time,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        taskId: TaskId.fromJson(json["taskId"]),
        points: json["Points"],
        time: json["time"],
        date: json["Date"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "taskId": taskId.toJson(),
        "Points": points,
        "time": time,
        "Date": date,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class TaskId {
    bool isDone;
    String id;
    String gitSource;
    String projectTudo;
    String teamId;
    String description;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    TaskId({
        required this.isDone,
        required this.id,
        required this.gitSource,
        required this.projectTudo,
        required this.teamId,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory TaskId.fromJson(Map<String, dynamic> json) => TaskId(
        isDone: json["isDone"],
        id: json["_id"],
        gitSource: json["gitSource"],
        projectTudo: json["projectTudo"],
        teamId: json["teamId"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "isDone": isDone,
        "_id": id,
        "gitSource": gitSource,
        "projectTudo": projectTudo,
        "teamId": teamId,
        "description": description,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class UserId {
    String id;
    String name;
    int number;
    String email;
    String password;
    String image;
    bool isDelete;
    bool isVerify;
    bool status;
    String roles;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    UserId({
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
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        status: json["status"],
        roles: json["roles"],
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
        "image": image,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "status": status,
        "roles": roles,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
