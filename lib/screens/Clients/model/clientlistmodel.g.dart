// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clientlistmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientListModel _$ClientListModelFromJson(Map<String, dynamic> json) =>
    ClientListModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientListModelToJson(ClientListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      status: json['status'] as bool,
      id: json['_id'] as String,
      name: json['name'] as String,
      number: json['number'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      isDelete: json['is_delete'] as bool,
      isVerify: json['isVerify'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      university: json['university'] as String,
      v: json['__v'] as int,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'status': instance.status,
      '_id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'email': instance.email,
      'password': instance.password,
      'university': instance.university,
      'is_delete': instance.isDelete,
      'isVerify': instance.isVerify,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'createdBy': instance.createdBy,
    };
