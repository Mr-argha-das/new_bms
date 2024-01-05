// To parse this JSON data, do
//
//     final taskCreateResponseModel = taskCreateResponseModelFromJson(jsonString);

import 'dart:convert';

TaskCreateResponseModel taskCreateResponseModelFromJson(String str) => TaskCreateResponseModel.fromJson(json.decode(str));

String taskCreateResponseModelToJson(TaskCreateResponseModel data) => json.encode(data.toJson());

class TaskCreateResponseModel {
    bool status;
    String message;
    Data data;

    TaskCreateResponseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskCreateResponseModel.fromJson(Map<String, dynamic> json) => TaskCreateResponseModel(
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
    String gitSource;
    String projectTudo;
    String teamId;
    String description;
    bool status;
    bool isDone;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.gitSource,
        required this.projectTudo,
        required this.teamId,
        required this.description,
        required this.status,
        required this.isDone,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        gitSource: json["gitSource"],
        projectTudo: json["projectTudo"],
        teamId: json["teamId"],
        description: json["description"],
        status: json["status"],
        isDone: json["isDone"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "gitSource": gitSource,
        "projectTudo": projectTudo,
        "teamId": teamId,
        "description": description,
        "status": status,
        "isDone": isDone,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
