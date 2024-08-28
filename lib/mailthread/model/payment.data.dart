// To parse this JSON data, do
//
//     final orderpaymenthestory = orderpaymenthestoryFromJson(jsonString);

import 'dart:convert';

Orderpaymenthestory orderpaymenthestoryFromJson(String str) => Orderpaymenthestory.fromJson(json.decode(str));

String orderpaymenthestoryToJson(Orderpaymenthestory data) => json.encode(data.toJson());

class Orderpaymenthestory {
    bool success;
    String message;
    List<Datum> data;

    Orderpaymenthestory({
        required this.success,
        required this.message,
        required this.data,
    });

    factory Orderpaymenthestory.fromJson(Map<String, dynamic> json) => Orderpaymenthestory(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    OrderId orderId;
    ClientId clientId;
    UserId userId;
    String amount;
    String transactionId;
    String paymentType;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.orderId,
        required this.clientId,
        required this.userId,
        required this.amount,
        required this.transactionId,
        required this.paymentType,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        orderId: OrderId.fromJson(json["order_id"]),
        clientId: ClientId.fromJson(json["client_id"]),
        userId: UserId.fromJson(json["user_id"]),
        amount: json["amount"],
        transactionId: json["transaction_id"],
        paymentType: json["payment_type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "order_id": orderId.toJson(),
        "client_id": clientId.toJson(),
        "user_id": userId.toJson(),
        "amount": amount,
        "transaction_id": transactionId,
        "payment_type": paymentType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ClientId {
    String id;
    String name;
    int number;
    String email;

    ClientId({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
    });

    factory ClientId.fromJson(Map<String, dynamic> json) => ClientId(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "email": email,
    };
}

class OrderId {
    String id;
    String orderNumber;

    OrderId({
        required this.id,
        required this.orderNumber,
    });

    factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
        id: json["_id"],
        orderNumber: json["orderNumber"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderNumber": orderNumber,
    };
}

class UserId {
    String id;
    String name;
    int number;
    String email;
    String rmCode;
    String symbol;

    UserId({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.rmCode,
        required this.symbol,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        rmCode: json["rmCode"],
        symbol: json["symbol"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "email": email,
        "rmCode": rmCode,
        "symbol": symbol,
    };
}
