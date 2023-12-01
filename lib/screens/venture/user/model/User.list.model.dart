// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
part 'User.list.model.g.dart';

@JsonSerializable()
class UserListModel {
  @JsonKey(name: 'Status')
  bool status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  List<Datum> data;

  UserListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'number')
  int number;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'is_Delete')
  bool isDelete;
  @JsonKey(name: 'isVerify')
  bool isVerify;
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'roles')
  Roles roles;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: '__v')
  int v;

  Datum({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.password,
    required this.image,
    required this.isDelete,
    required this.isVerify,
    required this.status,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Roles {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: '__v')
  int v;

  Roles({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}
