// To parse this JSON data, do
//
//     final paymentBodyModel = paymentBodyModelFromJson(jsonString);

import 'dart:convert';

PaymentBodyModel paymentBodyModelFromJson(String str) => PaymentBodyModel.fromJson(json.decode(str));

String paymentBodyModelToJson(PaymentBodyModel data) => json.encode(data.toJson());

class PaymentBodyModel {
    String orderId;
    String userId;
    String clientId;
    String paymentType;
    String transactionId;
    String amount;

    PaymentBodyModel({
        required this.orderId,
        required this.userId,
        required this.clientId,
        required this.paymentType,
        required this.transactionId,
        required this.amount,
    });

    factory PaymentBodyModel.fromJson(Map<String, dynamic> json) => PaymentBodyModel(
        orderId: json["order_id"],
        userId: json["user_id"],
        clientId: json["client_id"],
        paymentType: json["payment_type"],
        transactionId: json["transaction_id"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "client_id": clientId,
        "payment_type": paymentType,
        "transaction_id": transactionId,
        "amount": amount,
    };
}
