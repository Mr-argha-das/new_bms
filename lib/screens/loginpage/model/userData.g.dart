// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['_id'] as String,
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String,
      isDelete: json['is_delete'] as bool,
      isVerify: json['isVerify'] as bool,
      status: json['status'] as bool,
      roles: Roles.fromJson(json['roles'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'is_delete': instance.isDelete,
      'isVerify': instance.isVerify,
      'status': instance.status,
      'roles': instance.roles,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'token': instance.token,
    };
