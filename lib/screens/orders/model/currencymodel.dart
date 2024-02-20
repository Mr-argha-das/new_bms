// To parse this JSON data, do
//
//     final currencymodel = currencymodelFromJson(jsonString);

import 'dart:convert';

Currencymodel currencymodelFromJson(String str) => Currencymodel.fromJson(json.decode(str));

String currencymodelToJson(Currencymodel data) => json.encode(data.toJson());

class Currencymodel {
    bool status;
    String message;
    List<Datum> data;

    Currencymodel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Currencymodel.fromJson(Map<String, dynamic> json) => Currencymodel(
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
    String name;
    String type;
    String symbol;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.name,
        required this.type,
        required this.symbol,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
