import 'package:admin/screens/Clients/model/clientAddResponse.dart';
import 'package:admin/screens/Clients/model/clientlistmodel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';
part 'client_api_service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class ClientService{
  factory ClientService(Dio dio) = _ClientService;

  @GET('/client-list-get/by-userId/{id}')
  Future<ClientListModel> getClientList(@Path('id') String id);
  @POST('/client-create')
  Future<ClientAddResponse> addClientAdd(@Body() ClientAddBody clientAddBody);

}


// To parse this JSON data, do
//
//     final clientAddResponse = clientAddResponseFromJson(jsonString);


// To parse this JSON data, do
//
//     final clientAddBody = clientAddBodyFromJson(jsonString);


ClientAddBody clientAddBodyFromJson(String str) => ClientAddBody.fromJson(json.decode(str));

String clientAddBodyToJson(ClientAddBody data) => json.encode(data.toJson());

class ClientAddBody {
    String name;
    String number;
    String email;
    String password;
    String createdBy;
    String university;

    ClientAddBody({
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.createdBy,
        required this.university,
    });

    factory ClientAddBody.fromJson(Map<String, dynamic> json) => ClientAddBody(
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        createdBy: json["createdBy"],
        university: json["university"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "email": email,
        "password": password,
        "createdBy": createdBy,
        "university": university,
    };
}


