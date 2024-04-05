

import 'package:admin/screens/orders/model/add.order.body.model.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:admin/screens/orders/model/sharmodel.dart';
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
  @GET('/allocation-list')
  Future<AllocationListmodel> getAllocvationList();
  @POST('/order-create')
  Future<OrderAddResponse> addOrder(@Body() AddOrderBody body);
  @POST('/order-list-create')
  Future<CreateSharReseModel> shareOrder(@Body() CreateShareModel body);
}

