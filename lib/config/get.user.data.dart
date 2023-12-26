import 'package:flutter/material.dart';
import 'package:session_storage/session_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataGet extends ChangeNotifier {
  String? _id;
  String? _name;
  String? _number;
  String? _email;
  String? _image;
  String? _roleId;

  String get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  String get number {
    return _number!;
  }

  String get email {
    return _email!;
  }

  String get image {
    return _image!;
  }

  String get roleId {
    return _roleId!;
  }

  set id(String value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  set number(String value) {
    _number = value;
  }

  set email(String value) {
    _email = value;
  }

  set image(String value) {
    _image = value;
  }

  set roleId(String value) {
    _roleId = value;
  }

  void setData(
      {required String id,
      required String name,
      required String number,
      required String email,
      required String image,
      required String roleId}) async {
    id = id;
    name = name;
    email = email;
    number = number;
    image = image;
    roleId = roleId;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('id', id);
    // await pref.setString('name', name);
    // await pref.setString('number', number);
    // await pref.setString('email', email);
    // await pref.setString('image', image);
    // await pref.setString('roleid', roleId);
    SessionStorage()
      ..addAll({
        'id': id,
        'name': name,
        'number': number,
        'email': email,
        'image': image,
        'roleid': roleId
      });
  }

  void getUserLocalData() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // id = pref.getString('id')!;
    // name = pref.getString('name')!;
    // number = pref.getString('number')!;
    // email = pref.getString('email')!;
    // image = pref.getString('image')!;
    // roleId = pref.getString('roleid')!;
     final session = SessionStorage();
     id = session['id'].toString();
     name = session['name'].toString();
     number = session['number'].toString();
     email = session['email'].toString();
     image = session['image'].toString();
     roleId = session['roleid'].toString();
  }
}
