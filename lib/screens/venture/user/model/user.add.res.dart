// To parse this JSON data, do
//
//     final userAddResponse = userAddResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'user.add.res.g.dart';
@JsonSerializable()
class UserAddResponse {
  @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name:'data')
    Data data;

    UserAddResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserAddResponse.fromJson(Map<String, dynamic> json) => _$UserAddResponseFromJson(
    json
    );

    Map<String, dynamic> toJson() => _$UserAddResponseToJson(this);
}

@JsonSerializable()
class Data {
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
    @JsonKey(name: 'isDelete')
    bool isDelete;
    @JsonKey(name: 'isVerify')
    bool isVerify;
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'roles')
    String roles;
    @JsonKey(name: 'teams')
    String teams;
    @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;

    Data({
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.image,
        required this.isDelete,
        required this.isVerify,
        required this.status,
        required this.roles,
        required this.teams,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
