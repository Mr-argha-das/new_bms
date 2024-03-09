// To parse this JSON data, do
//
//     final orderAddResponse = orderAddResponseFromJson(jsonString);

import 'dart:convert';

OrderAddResponse orderAddResponseFromJson(String str) => OrderAddResponse.fromJson(json.decode(str));

String orderAddResponseToJson(OrderAddResponse data) => json.encode(data.toJson());

class OrderAddResponse {
    bool status;
    String message;
    Data data;

    OrderAddResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory OrderAddResponse.fromJson(Map<String, dynamic> json) => OrderAddResponse(
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
    OderDetails oderDetails;
    GroupDetails groupDetails;

    Data({
        required this.oderDetails,
        required this.groupDetails,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        oderDetails: OderDetails.fromJson(json["OderDetails"]),
        groupDetails: GroupDetails.fromJson(json["GroupDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "OderDetails": oderDetails.toJson(),
        "GroupDetails": groupDetails.toJson(),
    };
}

class GroupDetails {
    String groupName;
    bool status;
    String creater;
    String orderId;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
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

    factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        groupName: json["groupName"],
        status: json["status"],
        creater: json["creater"],
        orderId: json["orderId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "status": status,
        "creater": creater,
        "orderId": orderId,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class OderDetails {
    String orderNumber;
    String clientId;
    String currencyId;
    String serviceId;
    String userId;
    String inrAmmount;
    String audAmmount;
    String clientAmmount;
    String totalAmmount;
    String ppt;
    String moduleCode;
    String moduleName;
    String deadline;
    String wordCount;
    String paymentType;
    String shortNote;
    String image;
    String file;
    String date;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
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

    factory OderDetails.fromJson(Map<String, dynamic> json) => OderDetails(
        orderNumber: json["orderNumber"],
        clientId: json["clientId"],
        currencyId: json["currencyId"],
        serviceId: json["serviceId"],
        userId: json["userId"],
        inrAmmount: json["inrAmmount"],
        audAmmount: json["audAmmount"],
        clientAmmount: json["clientAmmount"],
        totalAmmount: json["totalAmmount"],
        ppt: json["PPT"],
        moduleCode: json["moduleCode"],
        moduleName: json["moduleName"],
        deadline: json["deadline"],
        wordCount: json["wordCount"],
        paymentType: json["paymentType"],
        shortNote: json["shortNote"],
        image: json["image"],
        file: json["file"],
        date: json["Date"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "orderNumber": orderNumber,
        "clientId": clientId,
        "currencyId": currencyId,
        "serviceId": serviceId,
        "userId": userId,
        "inrAmmount": inrAmmount,
        "audAmmount": audAmmount,
        "clientAmmount": clientAmmount,
        "totalAmmount": totalAmmount,
        "PPT": ppt,
        "moduleCode": moduleCode,
        "moduleName": moduleName,
        "deadline": deadline,
        "wordCount": wordCount,
        "paymentType": paymentType,
        "shortNote": shortNote,
        "image": image,
        "file": file,
        "Date": date,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
