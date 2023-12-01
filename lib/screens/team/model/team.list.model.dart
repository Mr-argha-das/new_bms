// To parse this JSON data, do
//
//     final teamListModel = teamListModelFromJson(jsonString);
import 'package:json_annotation/json_annotation.dart';

part 'team.list.model.g.dart';

@JsonSerializable()
class TeamListModel {
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name: 'data')
    List<Datum> data;

    TeamListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TeamListModel.fromJson(Map<String, dynamic> json) => _$TeamListModelFromJson(json);

    Map<String, dynamic> toJson() => _$TeamListModelToJson(this);
}
@JsonSerializable()
class Datum {
  @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'name')
    String name;
    @JsonKey(name: 'type')
    String type;
    @JsonKey(name: 'vId')
    VenturData? vId;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;

    Datum({
        required this.id,
        required this.name,
        required this.type,
        required this.vId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}


@JsonSerializable()
class VenturData {
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

    VenturData({
        required this.id,
        required this.name,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory VenturData.fromJson(Map<String, dynamic> json) => _$VenturDataFromJson(json);

    Map<String, dynamic> toJson() => _$VenturDataToJson(this);
}
