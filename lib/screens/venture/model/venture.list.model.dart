// To parse this JSON data, do
//
//     final ventureListModel = ventureListModelFromJson(jsonString);


import 'package:json_annotation/json_annotation.dart';
part 'venture.list.model.g.dart';

@JsonSerializable()
class VentureListModel {
  @JsonKey(name:'status')
    bool status;
    @JsonKey(name:'message')
    String message;
    @JsonKey(name: 'data')
    List<Datum> data;

    VentureListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory VentureListModel.fromJson(Map<String, dynamic> json) => _$VentureListModelFromJson(json);

    Map<String, dynamic> toJson() => _$VentureListModelToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'name')
    String name;
    @JsonKey(name: 'type')
    String type;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name:'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;

    Datum({
        required this.id,
        required this.name,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}
