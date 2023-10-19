import 'package:admin/screens/loginpage/model/userData.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';
@JsonSerializable()
class LoginResponse{
  @JsonKey(name:'status')
  final bool status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final UserData userData;

  LoginResponse({required this.status, required this.message, required this.userData});
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}