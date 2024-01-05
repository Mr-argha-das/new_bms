import 'package:admin/config/rolesmodel/roles.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rolesservice.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class RolesService{
  factory RolesService(Dio dio) = _RolesService;
  @GET('/role-gets')
  Future<RolesList> getRolesList();
}