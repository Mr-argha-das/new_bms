// import 'package:admin/screens/loginpage/model/userData.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
//   static String? iD;
//   static String? namE;
//   static String? numbeR;
//   static String? emaiL;
//   static String? imagE;
//   static String? roleiD;

//   // static setUserData(UserData data) {
//   //   id = data.id;
//   //   name = data.name;
//   //   email = data.email;
//   //   number = data.number.toString();
//   //   image = data.image.toString();
//   //   roleid = data.roles.id;
//   // }

//   static setUserData(UserData data) async {
//     iD = data.id;
//     namE = data.name;
//     emaiL = data.email;
//     numbeR = data.number.toString();
//     imagE = data.image.toString();
//     roleiD = data.roles.id;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

// // Save an integer value to 'counter' key.
//     await prefs.setString('id', data.id);
//     await prefs.setString('name', data.name);
//     await prefs.setString('email', data.email);
//     await prefs.setString('number', data.number.toString());
//     await prefs.setString('image', data.image.toString());
//     await prefs.setString('roleid', data.roles.id);
//   }

//   static String getUserStoreId() {
//     return iD!;
//   }

//   static getUserAllStorData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? id = prefs.getString('id');
//     String? name = prefs.getString('name');
//     String? email = prefs.getString('email');
//     String? number = prefs.getString('number');
//     String? image = prefs.getString('image');
//     String? roleid = prefs.getString('roleid');
    
//     iD = id;
//     namE = name;
//     emaiL = email;
//     numbeR = number;
//     roleiD = roleid;
//     imagE = image;     




//   }
// }

// class LocalStorageUser {
//   final String id;
//   final String name;
//   final String email;
//   final String number;
//   final String image;
//   final String roleid;

//   LocalStorageUser(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.number,
//       required this.image,
//       required this.roleid});
// }


// class UserStorageData{
//   final String id;
//   final String name;
//   final String email;
//   final String number;
//   final String image;
//   final String roleid;

//   UserStorageData(this.id, this.name, this.email, this.number, this.image, this.roleid);


// }