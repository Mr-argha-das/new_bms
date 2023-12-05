import 'package:admin/config/pretty.dio.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/Clients/main.client.dart';

import 'package:admin/screens/Clients/views/Add.client.form.dart';
import 'package:admin/screens/Clients/views/list.main.dart';
import 'package:admin/screens/Master/Allocation.dart';
import 'package:admin/screens/Master/QC.dart';
import 'package:admin/screens/Task.add/AddToDotask.dart';
import 'package:admin/screens/Task.add/ToDotask.dart';

import 'package:admin/screens/dashboard/Profile_pages/profile.page.dart';
import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/main.orders.dart';
import 'package:admin/screens/team/main.team.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:admin/screens/venture/main.venture.dart';
import 'package:admin/screens/venture/service/api_service.dart';
import 'package:admin/screens/venture/user/main.use.dart';
import 'package:admin/screens/venture/user/service/user.service.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class Env {
  static final appRoutes = {
    '/': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, LoginService>(
              update: (context, dio, apiService) =>
                  apiService ?? LoginService(dio),
            ),
          ],
          child: Allocation(),
        ),
    '/dashboard': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController())
          ],
          child: MainScreen(),
        ),
    '/venture-list': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, VentureService>(
              update: (context, dio, apiService) =>
                  apiService ?? VentureService(dio),
            ),
          ],
          child: MainVenture(),
        ),
    '/team-list': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, AddTeamApi>(
              update: (context, dio, apiService) =>
                  apiService ?? AddTeamApi(dio),
            ),
          ],
          child: TeamMain(),
        ),
    '/user-list': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, UserService>(
              update: (context, dio, apiService) => apiService ?? UserService(),
            ),
          ],
          child: UsrMain(),
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
    '/profile-user': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
          ],
          child: ProfilePage(),
        ),
    '/add-venture': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController())
          ],
          child: MainVenture(),
        )
  };
}

String appbaseUrl = "https://squid-app-3-s689g.ondigitalocean.app";
