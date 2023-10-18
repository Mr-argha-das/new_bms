import 'dart:js';

import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/dashboard/Profile_pages/profile.page.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/main.orders.dart';
import 'package:admin/screens/team/main.team.dart';
import 'package:admin/screens/Clients/main.client.dart';
import 'package:admin/screens/user/main.use.dart';
import 'package:admin/screens/venture/main.venture.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routerDelegate = BeamerDelegate(
      transitionDelegate: NoAnimationTransitionDelegate(),
      locationBuilder: RoutesLocationBuilder(routes: {
        '/': (context, state, data) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuAppController())
              ],
              child: ProfilePage(),
            ),
        '/venture-list': (context, state, data) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuAppController())
              ],
              child: MainVenture(),
            ),
        '/team-list': (context, state, data) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuAppController())
              ],
              child: TeamMain(),
            ),
        '/user-list': (context, state, data) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuAppController())
              ],
              child: MainUSer(),
            ),
        '/client-list': (context, state, data) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuAppController())
              ],
              child: MainUSer(),
            ),
        '/orders-list': (context, state, data) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuAppController())
              ],
              child: MainOrder(),
            ),
        // '/user-list':(context, state, data) => UsrMain(),
        // '/client-list':(context, state, data)=> MainUSer(),
        // '/orders-list':(context, state, data) => MainOrder(),
      }));
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),

      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //       create: (context) => MenuAppController(),
      //     ),
      //   ],
      //   child: ProfilePage(),
      // ),

      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //       create: (context) => MenuAppController(),
      //     ),
      //   ],

      //   child: MainScreen(),

      // ),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
