// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'service.model.g.dart';
@JsonSerializable()
class ServiceModel {
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name: 'data')
    List<Datum> data;

    ServiceModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(
    json
    );

    Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

@JsonSerializable()
class Datum {
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
