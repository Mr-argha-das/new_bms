import 'package:admin/screens/venture/user/model/User.list.model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
part 'user.service.g.dart';

@RestApi(baseUrl: "https://squid-app-3-s689g.ondigitalocean.app")
abstract class UserService {
  factory UserService(Dio dio) = _UserService;
  @GET("/user")
  Future<UserListModel> getUserList();
}
