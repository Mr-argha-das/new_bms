// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskaddmodelres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAddResponseModel _$TaskAddResponseModelFromJson(
        Map<String, dynamic> json) =>
    TaskAddResponseModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskAddResponseModelToJson(
        TaskAddResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: json['userId'] as String,
      taskId: json['taskId'] as String,
      points: (json['Points'] as num).toInt(),
      time: json['time'] as String,
      date: json['Date'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'userId': instance.userId,
      'taskId': instance.taskId,
      'Points': instance.points,
      'time': instance.time,
      'Date': instance.date,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
