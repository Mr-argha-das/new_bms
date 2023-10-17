import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/dashboard/Profile_pages/profile.page.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/team/main.team.dart';
import 'package:admin/screens/Clients/main.client.dart';
import 'package:admin/screens/venture/main.venture.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
<<<<<<< HEAD
        child: TeamMain(),
=======
<<<<<<< HEAD
        child: ProfilePage(),
=======
        child: MainScreen(),
>>>>>>> 20fe2e206c679b3eafc0d510537e1e82904df853
>>>>>>> cb44927d96d8c612d94cc47350cb5e33d8816be2
      ),
    );
  }
}
