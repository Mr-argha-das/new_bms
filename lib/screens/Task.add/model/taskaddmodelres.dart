// To parse this JSON data, do
//
//     final taskAddResponseModel = taskAddResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'taskaddmodelres.g.dart';
@JsonSerializable()
class TaskAddResponseModel {
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name: 'data')
    Data data;

    TaskAddResponseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TaskAddResponseModel.fromJson(Map<String, dynamic> json) => _$TaskAddResponseModelFromJson(
   json
    );

    Map<String, dynamic> toJson() => _$TaskAddResponseModelToJson(this);
}
@JsonSerializable()
class Data {
    @JsonKey(name: 'userId')
    String userId;
    @JsonKey(name: 'taskId')
    String taskId;
    @JsonKey(name: 'Points')
    int points;
    @JsonKey(name: 'time')
    String time;
    @JsonKey(name: 'Date')
    String date;
    @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;

    Data({
        required this.userId,
        required this.taskId,
        required this.points,
        required this.time,
        required this.date,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(
       json
    );

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
