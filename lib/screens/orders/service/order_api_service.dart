import 'dart:io';

import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
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
    @Part() required String clientId,
    @Part() required String currencyId,
    @Part() required String serviceId,
    @Part() required String inrAmmount,
    @Part() required String audAmmount,
    @Part() required String clientAmmount,
    @Part() required String totalAmmount,
    @Part() required String PPT,
    @Part() required String moduleCode,
    @Part() required String moduleName,
    @Part() required String deadline,
    @Part() required String wordCount,
    @Part() required String paymentType,
    @Part() required String shortNote,
    @Part() required File image,
    @Part() required File file,
    @Part() required String userId,
  });
}
