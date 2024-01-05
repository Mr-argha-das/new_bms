import 'package:admin/screens/venture/model/model.dart';
import 'package:admin/screens/venture/model/venture.list.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class VentureService {
  factory VentureService(Dio dio) = _VentureService;

  @GET('/ventures')
  Future<VentureListModel> getVentureList();

  @POST('/venture-create')
  Future<VentureCreateResponse> ventureCreate(
      @Body() VentureCreateField fieldData);
}

@JsonSerializable()
class VentureCreateField {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'status')
  bool status;

  VentureCreateField({
    required this.name,
    required this.type,
    required this.status,
  });

  factory VentureCreateField.fromJson(Map<String, dynamic> json) =>
      _$VentureCreateFieldFromJson(json);

  Map<String, dynamic> toJson() => _$VentureCreateFieldToJson(this);
}
