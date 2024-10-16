// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.list.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamListModel _$TeamListModelFromJson(Map<String, dynamic> json) =>
    TeamListModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamListModelToJson(TeamListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      vId: json['vId'] == null
          ? null
          : VenturData.fromJson(json['vId'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'vId': instance.vId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

VenturData _$VenturDataFromJson(Map<String, dynamic> json) => VenturData(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$VenturDataToJson(VenturData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
