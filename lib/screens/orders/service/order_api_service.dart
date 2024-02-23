

import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'order_api_service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class OrderService {
  factory OrderService(Dio dio) = _OrderService;

  @GET('/order-find/{id}')
  Future<OrderListModel> getOrderListByUserId(@Path('id') String id);
  @GET('/service-get')
  Future<ServiceModel> getService();
  @GET('/currency-get')
  Future<Currencymodel> getCurrency();
  @POST('/order-create')
  @MultiPart()
  Future<OrderAddResponse> addOrder({
  @Part() required Map<String, dynamic> data
  });
}
