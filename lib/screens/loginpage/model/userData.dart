import 'package:admin/screens/loginpage/model/roles.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userData.g.dart';
@JsonSerializable()
class UserData {
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
    @JsonKey(name: 'image')
    String image;
    @JsonKey(name: 'is_delete')
    bool isDelete;
    @JsonKey(name: 'isVerify')
    bool isVerify;
    @JsonKey(name: 'status')
    bool status;
    @JsonKey(name: 'roles')
    Roles roles;
    @JsonKey(name: 'createdAt')
    DateTime createdAt;
    @JsonKey(name: 'updatedAt')
    DateTime updatedAt;
    @JsonKey(name: '__v')
    int v;
    @JsonKey(name: 'token')
    String token;
    

    UserData({
        required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.password,
        required this.image,
        required this.isDelete,
        required this.isVerify,
        required this.status,
        required this.roles,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.token,
    });
    factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

    Map<String, dynamic> toJson() => _$UserDataToJson(this);

}
