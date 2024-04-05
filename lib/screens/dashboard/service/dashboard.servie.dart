import 'package:admin/screens/dashboard/models/dashboard.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'dashboard.servie.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class DashboardService{
  factory DashboardService(Dio dio) = _DashboardService;
  @GET('/wordcount/get/{id}')
  Future<DashboardBalanceModel> getBalance(@Path('id') String userid, @Query('startDate') String startdate, @Query('endDate') String endDate);
}