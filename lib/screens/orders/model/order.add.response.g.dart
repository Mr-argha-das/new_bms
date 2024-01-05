// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.add.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAddResponse _$OrderAddResponseFromJson(Map<String, dynamic> json) =>
    OrderAddResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderAddResponseToJson(OrderAddResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      oderDetails:
          OderDetails.fromJson(json['OderDetails'] as Map<String, dynamic>),
      groupDetails:
          GroupDetails.fromJson(json['GroupDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'OderDetails': instance.oderDetails,
      'GroupDetails': instance.groupDetails,
    };

GroupDetails _$GroupDetailsFromJson(Map<String, dynamic> json) => GroupDetails(
      groupName: json['groupName'] as String,
      status: json['status'] as bool,
      creater: json['creater'] as String,
      orderId: json['orderId'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$GroupDetailsToJson(GroupDetails instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'status': instance.status,
      'creater': instance.creater,
      'orderId': instance.orderId,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

OderDetails _$OderDetailsFromJson(Map<String, dynamic> json) => OderDetails(
      orderNumber: json['orderNumber'] as String,
      clientId: json['clientId'] as String,
      currencyId: json['currencyId'] as String,
      serviceId: json['serviceId'] as String,
      userId: json['userId'] as String,
      inrAmmount: json['inrAmmount'] as String,
      audAmmount: json['audAmmount'] as String,
      clientAmmount: json['clientAmmount'] as String,
      totalAmmount: json['totalAmmount'] as String,
      ppt: json['ppt'] as String,
      moduleCode: json['moduleCode'] as String,
      moduleName: json['moduleName'] as String,
      deadline: json['deadline'] as String,
      wordCount: json['wordCount'] as String,
      paymentType: json['paymentType'] as String,
      shortNote: json['shortNote'] as String,
      image: json['image'] as String,
      file: json['file'] as String,
      date: json['date'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$OderDetailsToJson(OderDetails instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'clientId': instance.clientId,
      'currencyId': instance.currencyId,
      'serviceId': instance.serviceId,
      'userId': instance.userId,
      'inrAmmount': instance.inrAmmount,
      'audAmmount': instance.audAmmount,
      'clientAmmount': instance.clientAmmount,
      'totalAmmount': instance.totalAmmount,
      'ppt': instance.ppt,
      'moduleCode': instance.moduleCode,
      'moduleName': instance.moduleName,
      'deadline': instance.deadline,
      'wordCount': instance.wordCount,
      'paymentType': instance.paymentType,
      'shortNote': instance.shortNote,
      'image': instance.image,
      'file': instance.file,
      'date': instance.date,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
