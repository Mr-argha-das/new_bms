// To parse this JSON data, do
//
//     final taskUpdateModel = taskUpdateModelFromJson(jsonString);

import 'dart:convert';

TaskUpdateModel taskUpdateModelFromJson(String str) => TaskUpdateModel.fromJson(json.decode(str));

String taskUpdateModelToJson(TaskUpdateModel data) => json.encode(data.toJson());

class TaskUpdateModel {
    bool status;
    String message;
    Data data;

    TaskUpdateModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskUpdateModel.fromJson(Map<String, dynamic> json) => TaskUpdateModel(
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
    String id;
    String gitSource;
    String projectTudo;
    String teamId;
    String description;
    bool status;
    bool isDone;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.id,
        required this.gitSource,
        required this.projectTudo,
        required this.teamId,
        required this.description,
        required this.status,
        required this.isDone,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        gitSource: json["gitSource"],
        projectTudo: json["projectTudo"],
        teamId: json["teamId"],
        description: json["description"],
        status: json["status"],
        isDone: json["isDone"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "gitSource": gitSource,
        "projectTudo": projectTudo,
        "teamId": teamId,
        "description": description,
        "status": status,
        "isDone": isDone,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
