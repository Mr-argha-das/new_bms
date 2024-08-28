// To parse this JSON data, do
//
//     final orderListModels = orderListModelsFromJson(jsonString);

import 'dart:convert';

OrderListModels orderListModelsFromJson(String str) => OrderListModels.fromJson(json.decode(str));

String orderListModelsToJson(OrderListModels data) => json.encode(data.toJson());

class OrderListModels {
    bool status;
    String message;
    List<Datum> data;

    OrderListModels({
        required this.status,
        required this.message,
        required this.data,
    });

    factory OrderListModels.fromJson(Map<String, dynamic> json) => OrderListModels(
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
    String totalInrAmmount;
    String clientPaidAmmountInr;
    String audAmmount;
    String clientAmmount;
    String totalAmmount;
    dynamic workPicked;
    String ppt;
    String moduleCode;
    String moduleName;
    String deadline;
    String wordCount;
    String correntWordCount;
    String paymentType;
    String shortNote;
    String image;
    bool praroty;
    String file;
    String? stream;
    String date;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<ShareStatus> shareStatus;

    Datum({
        required this.id,
        required this.orderNumber,
        required this.clientId,
        required this.currencyId,
        required this.serviceId,
        required this.userId,
        required this.inrAmmount,
        required this.totalInrAmmount,
        required this.clientPaidAmmountInr,
        required this.audAmmount,
        required this.clientAmmount,
        required this.totalAmmount,
        required this.workPicked,
        required this.ppt,
        required this.moduleCode,
        required this.moduleName,
        required this.deadline,
        required this.wordCount,
        required this.correntWordCount,
        required this.paymentType,
        required this.shortNote,
        required this.image,
        required this.praroty,
        required this.file,
        this.stream,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.shareStatus,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        orderNumber: json["orderNumber"],
        clientId: ClientId.fromJson(json["clientId"]),
        currencyId: json["currencyId"] == null ? null : CurrencyId.fromJson(json["currencyId"]),
        serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"]),
        userId: json["userId"],
        inrAmmount: json["inrAmmount"],
        totalInrAmmount: json["total_inrAmmount"],
        clientPaidAmmountInr: json["clientPaidAmmountInr"],
        audAmmount: json["audAmmount"],
        clientAmmount: json["clientAmmount"],
        totalAmmount: json["totalAmmount"],
        workPicked: json["workPicked"],
        ppt: json["PPT"],
        moduleCode: json["moduleCode"],
        moduleName: json["moduleName"],
        deadline: json["deadline"],
        wordCount: json["wordCount"],
        correntWordCount: json["correntWordCount"],
        paymentType: json["paymentType"],
        shortNote: json["shortNote"],
        image: json["image"],
        praroty: json["praroty"],
        file: json["file"],
        stream: json["stream"],
        date: json["Date"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        shareStatus: List<ShareStatus>.from(json["shareStatus"].map((x) => ShareStatus.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderNumber": orderNumber,
        "clientId": clientId.toJson(),
        "currencyId": currencyId?.toJson(),
        "serviceId": serviceId?.toJson(),
        "userId": userId,
        "inrAmmount": inrAmmount,
        "total_inrAmmount": totalInrAmmount,
        "clientPaidAmmountInr": clientPaidAmmountInr,
        "audAmmount": audAmmount,
        "clientAmmount": clientAmmount,
        "totalAmmount": totalAmmount,
        "workPicked": workPicked,
        "PPT": ppt,
        "moduleCode": moduleCode,
        "moduleName": moduleName,
        "deadline": deadline,
        "wordCount": wordCount,
        "correntWordCount": correntWordCount,
        "paymentType": paymentType,
        "shortNote": shortNote,
        "image": image,
        "praroty": praroty,
        "file": file,
        "stream": stream,
        "Date": date,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "shareStatus": List<dynamic>.from(shareStatus.map((x) => x.toJson())),
    };
}

class ClientId {
    String id;
    String name;
    int number;
    String email;
    String password;
    bool isDelete;
    bool status;
    bool isVerify;
    String university;
    String countryCode;
    String createdBy;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    ClientId({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.isDelete,
        required this.status,
        required this.isVerify,
        required this.university,
        required this.countryCode,
        required this.createdBy,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ClientId.fromJson(Map<String, dynamic> json) => ClientId(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        password: json["password"],
        isDelete: json["is_delete"],
        status: json["status"],
        isVerify: json["isVerify"],
        university: json["university"],
        countryCode: json["countryCode"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "email": email,
        "password": password,
        "is_delete": isDelete,
        "status": status,
        "isVerify": isVerify,
        "university": university,
        "countryCode": countryCode,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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

class ShareStatus {
    String id;
    String oderId;
    String sendar;
    String receiver;
    String status;
    String message;
    String file;
    String deailne;
    String wordCount;
    String correntWordCount;
    String topic;
    DateTime createdAt;
    DateTime updatedAt;
    String time;
    DateTime date;
    int v;

    ShareStatus({
        required this.id,
        required this.oderId,
        required this.sendar,
        required this.receiver,
        required this.status,
        required this.message,
        required this.file,
        required this.deailne,
        required this.wordCount,
        required this.correntWordCount,
        required this.topic,
        required this.createdAt,
        required this.updatedAt,
        required this.time,
        required this.date,
        required this.v,
    });

    factory ShareStatus.fromJson(Map<String, dynamic> json) => ShareStatus(
        id: json["_id"],
        oderId: json["oderId"],
        sendar: json["sendar"],
        receiver: json["receiver"],
        status: json["status"],
        message: json["message"],
        file: json["file"],
        deailne: json["deailne"],
        wordCount: json["word_count"],
        correntWordCount: json["correntWordCount"],
        topic: json["topic"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        time: json["time"],
        date: DateTime.parse(json["Date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "oderId": oderId,
        "sendar": sendar,
        "receiver": receiver,
        "status": status,
        "message": message,
        "file": file,
        "deailne": deailne,
        "word_count": wordCount,
        "correntWordCount": correntWordCount,
        "topic": topic,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "time": time,
        "Date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "__v": v,
    };
}
