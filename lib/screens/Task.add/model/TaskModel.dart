// To parse this JSON data, do
//
//     final taskListModel = taskListModelFromJson(jsonString);

import 'dart:convert';

TaskListModel taskListModelFromJson(String str) => TaskListModel.fromJson(json.decode(str));

String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());

class TaskListModel {
    bool status;
    String message;
    List<Datum> data;

    TaskListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
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
    bool isDone;
    String id;
    String gitSource;
    String projectTudo;
    TeamId? teamId;
    String description;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isDone: json["isDone"],
        id: json["_id"],
        gitSource: json["gitSource"],
        projectTudo: json["projectTudo"],
        teamId: json["teamId"] == null ? null : TeamId.fromJson(json["teamId"]),
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
        "teamId": teamId?.toJson(),
        "description": description,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class TeamId {
    String id;
    String name;
    String type;
    String vId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    TeamId({
        required this.id,
        required this.name,
        required this.type,
        required this.vId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory TeamId.fromJson(Map<String, dynamic> json) => TeamId(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        vId: json["vId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "vId": vId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
