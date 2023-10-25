
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'roles.g.dart';
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
