import 'dart:convert';

import 'package:admin/screens/venture/user/model/User.list.model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
class UserService{
  static Future<UserListModel> getUserList() async {
    final response = await http
        .get(Uri.parse('https://squid-app-3-s689g.ondigitalocean.app/user'));
    print("//////////////////////////////////////////////////");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return UserListModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}