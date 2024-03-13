import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:admin/screens/team/model/team.list.model.dart';
import 'package:admin/screens/team/model/team_response.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:convert';

part 'add_team_api.g.dart';


@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class AddTeamApi{
  factory AddTeamApi(Dio dio)= _AddTeamApi;
  @POST('/team-create')
  Future<TeamResponse> login(@Body() TeamAddModel teamAddModel);
  @GET('/teams')
  Future<TeamListModel> getTeamList();
  @PUT('/team-update/{teamid}')
  Future<TeamUpdateResModel> updateTeamData(@Path('teamid') String teamid, @Body() TeamAddModel body); 
}


TeamUpdateResModel teamUpdateResModelFromJson(String str) => TeamUpdateResModel.fromJson(json.decode(str));

String teamUpdateResModelToJson(TeamUpdateResModel data) => json.encode(data.toJson());

class TeamUpdateResModel {
    bool status;
    String message;
    Data data;

    TeamUpdateResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TeamUpdateResModel.fromJson(Map<String, dynamic> json) => TeamUpdateResModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String name;
    String type;
    String vId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.id,
        required this.name,
        required this.type,
        required this.vId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        vId: json["vId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "vId": vId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}


@JsonSerializable()
class TeamAddModel {
   
  @JsonKey(name:'name')
  final String name;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'vId')
  final String vId;

  factory TeamAddModel.fromJson(Map<String, dynamic> json) =>
      _$TeamAddModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamAddModelToJson(this);    

  TeamAddModel({required this.name, required this.type, required this.vId});
}