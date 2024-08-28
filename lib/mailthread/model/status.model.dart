// To parse this JSON data, do
//
//     final statusListModel = statusListModelFromJson(jsonString);

import 'dart:convert';

StatusListModel statusListModelFromJson(String str) =>
    StatusListModel.fromJson(json.decode(str));

String statusListModelToJson(StatusListModel data) =>
    json.encode(data.toJson());

class StatusListModel {
  bool status;
  String message;
  List<Datum> data;

  StatusListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StatusListModel.fromJson(Map<String, dynamic> json) =>
      StatusListModel(
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
  String oderId;
  String sendar;
  String receiver;
  String status;
  String message;
  String file;
  String date;
  String currentWordcount;
  DateTime createdAt;
  DateTime updatedAt;
  String deadline;
  String word_count;
  String topic;
  int v;

  Datum({
    required this.currentWordcount,
    required this.id,
    required this.oderId,
    required this.sendar,
    required this.receiver,
    required this.status,
    required this.message,
    required this.file,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.deadline,
    required this.topic,
    required this.word_count,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        oderId: json["oderId"],
        sendar: json["sendar"],
        receiver: json["receiver"],
        status: json["status"],
        message: json["message"],
        file: json["file"],
        date: json["Date"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        word_count: json["word_count"] ?? "--",
        topic: json["topic"] ?? "--",
        deadline: json["deailne"] ?? "--",
        currentWordcount: json["correntWordCount"] ?? "0",
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
        "Date": date,
        "deailne": deadline,
        "word_count": word_count,
        "topic": topic,
        "correntWordCount":currentWordcount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
