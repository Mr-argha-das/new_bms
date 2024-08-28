// To parse this JSON data, do
//
//     final paymentResponseModel = paymentResponseModelFromJson(jsonString);

import 'dart:convert';

PaymentResponseModel paymentResponseModelFromJson(String str) => PaymentResponseModel.fromJson(json.decode(str));

String paymentResponseModelToJson(PaymentResponseModel data) => json.encode(data.toJson());

class PaymentResponseModel {
    bool success;
    String message;
    String paymentId;

    PaymentResponseModel({
        required this.success,
        required this.message,
        required this.paymentId,
    });

    factory PaymentResponseModel.fromJson(Map<String, dynamic> json) => PaymentResponseModel(
        success: json["success"],
        message: json["message"],
        paymentId: json["paymentId"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "paymentId": paymentId,
    };
}
