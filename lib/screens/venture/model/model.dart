import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class VentureCreateResponse {
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  Data data;

  VentureCreateResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VentureCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$VentureCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VentureCreateResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
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
    required this.type,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
