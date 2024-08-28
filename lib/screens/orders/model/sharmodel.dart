// To parse this JSON data, do
//
//     final createShareModel = createShareModelFromJson(jsonString);

import 'dart:convert';

CreateShareModel createShareModelFromJson(String str) => CreateShareModel.fromJson(json.decode(str));

String createShareModelToJson(CreateShareModel data) => json.encode(data.toJson());

class CreateShareModel {
    String oderId;
    String sendar;
    String receiver;
    String status;
    String message;
    String topic;
    String word_count;
    String deadline;
    String file;
    String correntWordCount;

    CreateShareModel({
      required this.correntWordCount,
        required this.oderId,
        required this.sendar,
        required this.receiver,
        required this.status,
        required this.message,
        required this.file,
        required this.deadline,
        required this.topic,
        required this.word_count
    });

    factory CreateShareModel.fromJson(Map<String, dynamic> json) => CreateShareModel(
      
        oderId: json["oderId"],
        sendar: json["sendar"],
        receiver: json["receiver"],
        status: json["status"],
        message: json["message"],
        deadline: json["deailne"],
        topic: json["topic"],
        word_count: json["word_count"],
        correntWordCount: json["correntWordCount"],
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
   
        "oderId": oderId,
        "sendar": sendar,
        "receiver": receiver,
        "status": status,
        "message": message,
        "deailne":deadline,
        "topic":topic,
        "word_count":word_count,
           "correntWordCount":correntWordCount,
        "file": file,
    };
}

CreateSharReseModel createSharReseModelFromJson(String str) => CreateSharReseModel.fromJson(json.decode(str));

String createSharReseModelToJson(CreateSharReseModel data) => json.encode(data.toJson());

class CreateSharReseModel {
    bool status;
    String message;
    Data? data;

    CreateSharReseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CreateSharReseModel.fromJson(Map<String, dynamic> json) => CreateSharReseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String oderId;
    String sendar;
    String receiver;
    String status;
    String message;
    String file;
    String date;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.oderId,
        required this.sendar,
        required this.receiver,
        required this.status,
        required this.message,
        required this.file,
        required this.date,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        oderId: json["oderId"],
        sendar: json["sendar"],
        receiver: json["receiver"],
        status: json["status"],
        message: json["message"],
        file: json["file"],
        date: json["Date"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "oderId": oderId,
        "sendar": sendar,
        "receiver": receiver,
        "status": status,
        "message": message,
        "file": file,
        "Date": date,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}