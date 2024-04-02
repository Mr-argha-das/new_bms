// To parse this JSON data, do
//
//     final dashboardBalanceModel = dashboardBalanceModelFromJson(jsonString);

import 'dart:convert';

DashboardBalanceModel dashboardBalanceModelFromJson(String str) => DashboardBalanceModel.fromJson(json.decode(str));

String dashboardBalanceModelToJson(DashboardBalanceModel data) => json.encode(data.toJson());

class DashboardBalanceModel {
    String startDate;
    String endDate;
    int wordCountTotal;
    int totalAmmountTotal;

    DashboardBalanceModel({
        required this.startDate,
        required this.endDate,
        required this.wordCountTotal,
        required this.totalAmmountTotal,
    });

    factory DashboardBalanceModel.fromJson(Map<String, dynamic> json) => DashboardBalanceModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
        wordCountTotal: json["wordCountTotal"],
        totalAmmountTotal: json["totalAmmountTotal"],
    );

    Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "wordCountTotal": wordCountTotal,
        "totalAmmountTotal": totalAmmountTotal,
    };
}
