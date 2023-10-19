import 'package:admin/screens/loginpage/model/login_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart' hide Headers;
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;
  // ...
  @POST('/user-login')
  // @Headers(<String, dynamic>{
  //   'Content-Type': 'application/json',
  //   'Custom-Header': 'Your header',
  // })
  Future<LoginResponse> login(LoginModel loginModel);
}



@JsonSerializable()
class LoginModel {
  
  @JsonKey(name:'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);    

  LoginModel({required this.email, required this.password});
}