import 'dart:io';

import 'dart:convert';
import 'package:admin/screens/venture/user/model/User.list.model.dart';
import 'package:admin/screens/venture/user/model/user.add.res.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user.api.service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;


  @GET('/user')
  Future<UserListModel> getUserData();

  @POST('/user-create')
  Future<UserAddResponse> addUser(
    @Body() AddUserModel model
      );
     
  
}

// To parse this JSON data, do
//
//     final addUserModel = addUserModelFromJson(jsonString);


AddUserModel addUserModelFromJson(String str) => AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
    String image;
    String roles;
    String teams;
    String name;
    String email;
    int number;
    String password;

    AddUserModel({
        required this.image,
        required this.roles,
        required this.teams,
        required this.name,
        required this.email,
        required this.number,
        required this.password,
    });

    factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
        image: json["image"],
        roles: json["roles"],
        teams: json["teams"],
        name: json["name"],
        email: json["email"],
        number: json["number"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "roles": roles,
        "teams": teams,
        "name": name,
        "email": email,
        "number": number,
        "password": password,
    };
}
