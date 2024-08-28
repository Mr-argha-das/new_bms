import 'package:admin/mailthread/model/orderdetails.dart';
import 'package:admin/mailthread/model/payment.data.dart';
import 'package:admin/mailthread/model/status.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'status.service.g.dart';
@RestApi(baseUrl: "https://squid-app-3-s689g.ondigitalocean.app")
abstract class StatusService{
  factory StatusService(Dio dio) = _StatusService;
  @GET('/order-share-history/{id}')
  Future<StatusListModel> orderStatus(@Path('id') String id);
  @GET('/order-find/{id}')
  Future<OrderDetailsModel> orderDetails(@Path('id') String id);
  @GET('/order/payment/{id}')
  Future<Orderpaymenthestory> getPaymenthetory(@Path('id') String id);
} 