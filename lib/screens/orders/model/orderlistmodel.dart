// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
    bool status;
    String message;
    List<Datum> data;

    OrderListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String orderNumber;
    ClientId clientId;
    CurrencyId? currencyId;
    ServiceId? serviceId;
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
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
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
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        orderNumber: json["orderNumber"] ?? "",
        clientId: ClientId.fromJson(json["clientId"] ?? ""),
        currencyId: json["currencyId"] == null ? null : CurrencyId.fromJson(json["currencyId"] ?? ""),
        serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"] ?? ""),
        userId: json["userId"] ?? "",
        inrAmmount: json["inrAmmount"] ?? "",
        audAmmount: json["audAmmount"]?? "",
        clientAmmount: json["clientAmmount"]?? "",
        totalAmmount: json["totalAmmount"]?? "",
        ppt: json["PPT"]?? "",
        moduleCode: json["moduleCode"]?? "",
        moduleName: json["moduleName"]?? "",
        deadline: json["deadline"]?? "",
        wordCount: json["wordCount"]?? "",
        paymentType: json["paymentType"]?? "",
        shortNote: json["shortNote"]?? "",
        image: json["image"]?? "",
        file: json["file"]?? "",
        date: json["Date"]?? "",
        createdAt: DateTime.parse(json["createdAt"]?? ""),
        updatedAt: DateTime.parse(json["updatedAt"]?? ""),
        v: json["__v"]?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderNumber": orderNumber,
        "clientId": clientId.toJson(),
        "currencyId": currencyId?.toJson(),
        "serviceId": serviceId?.toJson(),
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ClientId {
    bool status;
    String id;
    String name;
    int number;
    String email;
    String password;
    bool isDelete;
    bool isVerify;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String createdBy;

    ClientId({
        required this.status,
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.isDelete,
        required this.isVerify,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.createdBy,
    });

    factory ClientId.fromJson(Map<String, dynamic> json) => ClientId(
        status: json["status"],
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        isDelete: json["is_delete"],
        isVerify: json["isVerify"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdBy: json["createdBy"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "name": name,
        "number": number,
        "email": email,
        "password": password,
        "is_delete": isDelete,
        "isVerify": isVerify,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "createdBy": createdBy,
    };
}

class CurrencyId {
    String id;
    String name;
    String type;
    String symbol;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    CurrencyId({
        required this.id,
        required this.name,
        required this.type,
        required this.symbol,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory CurrencyId.fromJson(Map<String, dynamic> json) => CurrencyId(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        symbol: json["symbol"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "symbol": symbol,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ServiceId {
    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    ServiceId({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
