// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.add.res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddResponse _$UserAddResponseFromJson(Map<String, dynamic> json) =>
    UserAddResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAddResponseToJson(UserAddResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String,
      isDelete: json['isDelete'] as bool,
      isVerify: json['isVerify'] as bool,
      status: json['status'] as bool,
      roles: json['roles'] as String,
      teams: json['teams'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'isDelete': instance.isDelete,
      'isVerify': instance.isVerify,
      'status': instance.status,
      'roles': instance.roles,
      'teams': instance.teams,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
