import 'package:admin/screens/venture/model/model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class VentureService {
  factory VentureService(Dio dio) = _VentureService;

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

  VentureCreateField({
    required this.name,
    required this.type,
  });

  factory VentureCreateField.fromJson(Map<String, dynamic> json) =>
      _$VentureCreateFieldFromJson(json);

  Map<String, dynamic> toJson() => _$VentureCreateFieldToJson(this);
}
