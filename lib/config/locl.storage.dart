import 'package:admin/screens/loginpage/model/userData.dart';

class LocalStorage {
  static String? id;
  static String? name;
  static String? number;
  static String? email;
  static String? image;
  static String? roleid;

  static setUserData(UserData data) {
    id = data.id;
    name = data.name;
    email = data.email;
    number = data.number.toString();
    image = data.image.toString();
    roleid = data.roles.id;
  }

  static String getUserStoreId() {
    return id!;
  }

  static Map getUserAllStorData() {
    return {
      id: id,
      name: name,
      email: email,
      number: number,
      image: image,
      roleid: roleid,
    };
  }
}
