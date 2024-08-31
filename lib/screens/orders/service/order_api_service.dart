

import 'package:admin/screens/orders/model/add.order.body.model.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/existing.order.dart';
import 'package:admin/screens/orders/model/existing.order.res.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/payment.body.dart';
import 'package:admin/screens/orders/model/payment.create.res.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:admin/screens/orders/model/sharmodel.dart';
import 'package:admin/screens/orders/model/teams.user.model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
part 'order_api_service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class OrderService {
  factory OrderService(Dio dio) = _OrderService;

  @GET('/order-find/{id}')
  Future<OrderListModels> getOrderListByUserId(@Path('id') String id);
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
  @POST('/order/payment/')
  Future<PaymentResponseModel> createPayment(@Body() PaymentBodyModel body);
  @GET('/user/teams/{id}')
  Future<UserJoinTeamsModel> userTeams(@Path("id") String id);
  @GET('/user-find/by-teamsId/{id}')
  Future<TeamsUsers> teamsUser(@Path("id") String id);
  @PUT('/order-update/{id}')
  Future<ExistingOrderResModel> updateOrder(@Path("id")String id, @Body() ExistingOrderModel body);
}







UserJoinTeamsModel userJoinTeamsModelFromJson(String str) => UserJoinTeamsModel.fromJson(json.decode(str));

String userJoinTeamsModelToJson(UserJoinTeamsModel data) => json.encode(data.toJson());

class UserJoinTeamsModel {
    bool status;
    String message;
    Data data;

    UserJoinTeamsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserJoinTeamsModel.fromJson(Map<String, dynamic> json) => UserJoinTeamsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    List<Team> teams;

    Data({
        required this.id,
        required this.teams,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
    };
}

class Team {
    String id;
    String name;
    String type;
    String vId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Team({
        required this.id,
        required this.name,
        required this.type,
        required this.vId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        vId: json["vId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "vId": vId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}


