// To parse this JSON data, do
//
//     final taskListModel = taskListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
part 'TaskModel.g.dart';

@JsonSerializable()
class TaskListModel {
  @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name: 'data')
    List<Datum> data;

    TaskListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskListModel.fromJson(Map<String, dynamic> json) => _$TaskListModelFromJson(
        json
    );

    Map<String, dynamic> toJson() => _$TaskListModelToJson(this);
}

@JsonSerializable()
class Datum {
 @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'gitSource')
    String gitSource;
    @JsonKey(name: 'projectTudo')
    String projectTudo;
    @JsonKey(name: 'teamId')
    dynamic teamId;
    @JsonKey(name: 'description')
    String description;
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(
      json
    );

    Map<String, dynamic> toJson() => _$DatumToJson(this);
        
}
