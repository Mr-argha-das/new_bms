import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:admin/screens/team/model/team_response.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
part 'add_team_api.g.dart';


@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class AddTeamApi{
  factory AddTeamApi(Dio dio)= _AddTeamApi;
  @POST('/team-create')
  Future<TeamResponse> login(@Body() TeamAddModel teamAddModel);
  
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