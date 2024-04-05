
import 'package:admin/screens/dashboard/Profile_pages/models/profile.models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
part 'profile.service.g.dart';
@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class ProfileService{
  factory ProfileService(Dio dio) = _ProfileService;
  @GET('/single-user/get-doc/{id}')
  Future<UserDetails> getData(@Path('id') String id);
}