import 'package:json_annotation/json_annotation.dart';


part 'model.g.dart';
@JsonSerializable()
class Task {
  const Task({this.id, this.name, this.avatar, this.createdAt});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}