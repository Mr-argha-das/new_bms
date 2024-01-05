// To parse this JSON data, do
//
//     final currencymodel = currencymodelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'currencymodel.g.dart';

@JsonSerializable()
class Currencymodel {
  @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name: 'data')
    List<Datum> data;

    Currencymodel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Currencymodel.fromJson(Map<String, dynamic> json) => _$CurrencymodelFromJson(json);

    Map<String, dynamic> toJson() => _$CurrencymodelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'name')
    String name;
    @JsonKey(name: 'type')
    String type;
    @JsonKey(name:'symbol')
    String symbol;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__V')
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

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(
       json
    );

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}
