// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clientAddResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientAddResponse _$ClientAddResponseFromJson(Map<String, dynamic> json) =>
    ClientAddResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientAddResponseToJson(ClientAddResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String,
      number: json['number'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      isDelete: json['is_delete'] as bool,
      status: json['status'] as bool,
      isVerify: json['isVerify'] as bool,
      university: json['university'] as String,
      createdBy: json['createdBy'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__V'] as int,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'email': instance.email,
      'password': instance.password,
      'is_delete': instance.isDelete,
      'status': instance.status,
      'isVerify': instance.isVerify,
      'university': instance.university,
      'createdBy': instance.createdBy,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__V': instance.v,
    };
