// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venture.list.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VentureListModel _$VentureListModelFromJson(Map<String, dynamic> json) =>
    VentureListModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VentureListModelToJson(VentureListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
