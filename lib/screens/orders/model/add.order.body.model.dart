// To parse this JSON data, do
//
//     final addOrderBody = addOrderBodyFromJson(jsonString);

import 'dart:convert';

AddOrderBody addOrderBodyFromJson(String str) => AddOrderBody.fromJson(json.decode(str));

String addOrderBodyToJson(AddOrderBody data) => json.encode(data.toJson());

class AddOrderBody {
    // String orderNumber;
    String stream;
    String clientId;
    String currencyId;
    String serviceId;
    int inrAmmount;
    int audAmmount;
    int clientAmmount;
    int totalAmmount;
    String clientPaidAmmountInr;
    String ppt;
    String moduleCode;
    String moduleName;
    String deadline;
    String wordCount;
    String paymentType;
    String shortNote;
    String image;
    String file;
    String userId;
    String correntWordCount;
    String total_inrAmmount;

    AddOrderBody({
      required this.stream,
      required this.total_inrAmmount,
      required this.clientPaidAmmountInr,
        required this.correntWordCount,
        required this.clientId,
        required this.currencyId,
        required this.serviceId,
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
        required this.userId,
    });

    factory AddOrderBody.fromJson(Map<String, dynamic> json) => AddOrderBody(
      stream: json["stream"],
      correntWordCount: json["correntWordCount"],
        // orderNumber: json["orderNumber"],
        total_inrAmmount : json["total_inrAmmount"],
        clientPaidAmmountInr: json["clientPaidAmmountInr"],
        clientId: json["clientId"],
        currencyId: json["currencyId"],
        serviceId: json["serviceId"],
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
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        // "orderNumber": orderNumber,
        "stream":stream,
        "clientPaidAmmountInr":clientPaidAmmountInr,
        "total_inrAmmount":total_inrAmmount,
        "correntWordCount":correntWordCount,
        "clientId": clientId,
        "currencyId": currencyId,
        "serviceId": serviceId,
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
        "userId": userId,
    };
}
