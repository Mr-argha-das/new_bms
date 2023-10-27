// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamResponse _$TeamResponseFromJson(Map<String, dynamic> json) => TeamResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      teamData: TeamData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamResponseToJson(TeamResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.teamData,
    };

TeamData _$TeamDataFromJson(Map<String, dynamic> json) => TeamData(
      name: json['name'] as String,
      type: json['type'] as String,
      vId: json['vId'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$TeamDataToJson(TeamData instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'vId': instance.vId,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
