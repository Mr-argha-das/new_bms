// To parse this JSON data, do
//
//     final clientListModel = clientListModelFromJson(jsonString);
import 'package:json_annotation/json_annotation.dart';
part 'clientlistmodel.g.dart';

@JsonSerializable()
class ClientListModel {
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'message')
    String message;
    @JsonKey(name: 'data')
    List<Datum> data;

    ClientListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ClientListModel.fromJson(Map<String, dynamic> json) => _$ClientListModelFromJson(json);
    Map<String, dynamic> toJson() => _$ClientListModelToJson(this);
}
@JsonSerializable()
class Datum {
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: '_id')
    String id;
    @JsonKey(name: 'name')
    String name;
    @JsonKey(name: 'number')
    int number;
    @JsonKey(name: 'email')
    String email;
    @JsonKey(name: 'password')
    String password;
    @JsonKey(name: 'is_delete')
    bool isDelete;
    @JsonKey(name: 'isVerify')
    bool isVerify;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;
    @JsonKey(name: 'createdBy')
    String createdBy;

    Datum({
        required this.status,
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.isDelete,
        required this.isVerify,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.createdBy,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(
        json
    );

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}
