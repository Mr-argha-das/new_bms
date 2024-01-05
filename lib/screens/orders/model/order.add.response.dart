// To parse this JSON data, do
//
//     final orderAddResponse = orderAddResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'order.add.response.g.dart';

@JsonSerializable()
class OrderAddResponse {
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  Data data;

  OrderAddResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderAddResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAddResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'OderDetails')
  OderDetails oderDetails;
  @JsonKey(name: 'GroupDetails')
  GroupDetails groupDetails;

  Data({
    required this.oderDetails,
    required this.groupDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class GroupDetails {
  @JsonKey(name: 'groupName')
  String groupName;
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'creater')
  String creater;
  @JsonKey(name: 'orderId')
  String orderId;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: '__v')
  int v;

  GroupDetails({
    required this.groupName,
    required this.status,
    required this.creater,
    required this.orderId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GroupDetails.fromJson(Map<String, dynamic> json) =>
      _$GroupDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDetailsToJson(this);
}

@JsonSerializable()
class OderDetails {
  @JsonKey(name: 'orderNumber')
  String orderNumber;
  @JsonKey(name: 'clientId')
  String clientId;
  @JsonKey(name: 'currencyId')
  String currencyId;
  @JsonKey(name:'serviceId')
  String serviceId;
  @JsonKey(name: 'userId')
  String userId;
  @JsonKey(name: 'inrAmmount')
  String inrAmmount;
  @JsonKey(name: 'audAmmount')
  String audAmmount;
  @JsonKey(name: 'clientAmmount')
  String clientAmmount;
  @JsonKey(name: 'totalAmmount')
  String totalAmmount;
  @JsonKey(name: 'ppt')
  String ppt;
  @JsonKey(name: 'moduleCode')
  String moduleCode;
  @JsonKey(name: 'moduleName')
  String moduleName;
  @JsonKey(name: 'deadline')
  String deadline;
  @JsonKey(name: 'wordCount')
  String wordCount;
  @JsonKey(name: 'paymentType')
  String paymentType;
  @JsonKey(name: 'shortNote')
  String shortNote;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'file')
  String file;
  @JsonKey(name: 'date')
  String date;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: '__v')
  int v;

  OderDetails({
    required this.orderNumber,
    required this.clientId,
    required this.currencyId,
    required this.serviceId,
    required this.userId,
    required this.inrAmmount,
    required this.audAmmount,
    required this.clientAmmount,
    required this.totalAmmount,
    required this.ppt,
    required this.moduleCode,
    required this.moduleName,
    required this.deadline,
    required this.wordCount,
    required this.paymentType,
    required this.shortNote,
    required this.image,
    required this.file,
    required this.date,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory OderDetails.fromJson(Map<String, dynamic> json) => _$OderDetailsFromJson(
     json
      );

  Map<String, dynamic> toJson() => _$OderDetailsToJson(this);
}
