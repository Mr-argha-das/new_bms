// To parse this JSON data, do
//
//     final rolesList = rolesListFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'roles.model.g.dart';

@JsonSerializable()
class RolesList {
  @JsonKey(name: "status")
    bool status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<Datum> data;

    RolesList({
        required this.status,
        required this.message,
        required this.data,
    });

    factory RolesList.fromJson(Map<String, dynamic> json) => _$RolesListFromJson(
    json
    );

    Map<String, dynamic> toJson() => _$RolesListToJson(this);
}
@JsonSerializable()
class Datum {
    @JsonKey(name: "_id")
    String id;
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "createdAt")
    DateTime createdAt;
    @JsonKey(name: "updatedAt")
    DateTime updatedAt;
    @JsonKey(name: "__v")
    int v;

    Datum({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(
        json
    );

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}
