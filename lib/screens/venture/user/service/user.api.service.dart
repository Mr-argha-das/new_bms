import 'dart:io';

import 'package:admin/screens/venture/user/model/user.add.res.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user.api.service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @POST('/user-create')
  @MultiPart()
  Future<UserAddResponse> addUser(
      {@Part() required Map<String, dynamic> data});
     
  
}
