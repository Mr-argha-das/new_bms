import 'package:json_annotation/json_annotation.dart';

part 'clientAddResponse.g.dart';

@JsonSerializable()
class ClientAddResponse {
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  Data data;

  ClientAddResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ClientAddResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClientAddResponseToJson(this);
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
  @JsonKey(name: 'is_delete')
  bool isDelete;
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'isVerify')
  bool isVerify;
  @JsonKey(name: 'university')
  String university;
  @JsonKey(name: 'createdBy')
  String createdBy;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: '__V')
  int v;

  Data({
    required this.name,
    required this.number,
    required this.email,
    required this.password,
    required this.isDelete,
    required this.status,
    required this.isVerify,
    required this.university,
    required this.createdBy,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
