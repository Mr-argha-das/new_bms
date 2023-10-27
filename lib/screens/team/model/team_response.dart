// To parse this JSON TeamData, do
//
//     final teamResponse = teamResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
part 'team_response.g.dart';
@JsonSerializable()
class TeamResponse {
    @JsonKey(name:'status')
    bool status;
    @JsonKey(name:'message')
    String message;
    @JsonKey(name:'data')
    TeamData teamData;

    TeamResponse({
        required this.status,
        required this.message,
        required this.teamData,
    });

    factory TeamResponse.fromJson(Map<String, dynamic> json) => _$TeamResponseFromJson(json);

    Map<String, dynamic> toJson() => _$TeamResponseToJson(this);
}

@JsonSerializable()
class TeamData {
  @JsonKey(name:'name')
    String name;
    @JsonKey(name:'type')
    String type;
    @JsonKey(name:'vId')
    String vId;
    @JsonKey(name:'_id')
    String id;
    @JsonKey(name:'createdAt')
    DateTime createdAt;
    @JsonKey(name:'updatedAt')
    DateTime updatedAt;
    @JsonKey(name:'__v')
    int v;

    TeamData({
        required this.name,
        required this.type,
        required this.vId,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory TeamData.fromJson(Map<String, dynamic> json) => _$TeamDataFromJson(json);

    Map<String, dynamic> toJson() => _$TeamDataToJson(this);
}
