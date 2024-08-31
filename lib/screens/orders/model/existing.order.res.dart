class ExistingOrderResModel {
    ExistingOrderResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    final bool? status;
    final String? message;
    final Data? data;

    factory ExistingOrderResModel.fromJson(Map<String, dynamic> json){ 
        return ExistingOrderResModel(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
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
        required this.stream,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? orderNumber;
    final String? clientId;
    final String? currencyId;
    final String? serviceId;
    final String? userId;
    final String? inrAmmount;
    final String? totalInrAmmount;
    final String? clientPaidAmmountInr;
    final String? audAmmount;
    final String? clientAmmount;
    final String? totalAmmount;
    final dynamic workPicked;
    final String? ppt;
    final String? moduleCode;
    final String? moduleName;
    final String? deadline;
    final String? wordCount;
    final String? correntWordCount;
    final String? paymentType;
    final String? shortNote;
    final String? image;
    final bool? praroty;
    final String? file;
    final String? stream;
    final String? date;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["_id"],
            orderNumber: json["orderNumber"],
            clientId: json["clientId"],
            currencyId: json["currencyId"],
            serviceId: json["serviceId"],
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
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderNumber": orderNumber,
        "clientId": clientId,
        "currencyId": currencyId,
        "serviceId": serviceId,
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };

}
