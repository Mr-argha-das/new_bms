import 'dart:js';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/config/rolesservices/rolesservice.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/Clients/main.client.dart';
import 'package:admin/screens/Clients/service/client_api_service.dart';
import 'package:admin/screens/Task.add/main.task.dart';
import 'package:admin/screens/Task.add/service/TaskApiService.dart';
import 'package:admin/screens/dashboard/Profile_pages/profile.page.dart';
import 'package:admin/screens/loginpage/login.page.dart';
import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orderhestory/views/order.perticuler.dart';
import 'package:admin/screens/orders/main.orders.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:admin/screens/orders/views/Add.order.dart';
import 'package:admin/screens/team/main.team.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:admin/screens/venture/main.venture.dart';
import 'package:admin/screens/venture/user/main.use.dart';
import 'package:admin/screens/venture/user/service/user.api.service.dart';
import 'package:admin/screens/venture/user/service/user.service.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../screens/venture/service/api_service.dart';

class Env {
  static final appRoutes = {
    '/add-order': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(create: (context) => createDio()),
            ProxyProvider<Dio, OrderService>(
              update: (context, dio, apiService) =>
                  apiService ?? OrderService(dio),
            ),
            ProxyProvider<Dio, ClientService>(
                update: (context, dio, apiService) =>
                    apiService ?? ClientService(dio))
          ],
          child: MainAddOrder(),
        ),
    '/': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            ChangeNotifierProvider(create: (context) => UserDataGet()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, LoginService>(
              update: (context, dio, apiService) =>
                  apiService ?? LoginService(dio),
            ),
          ],
          child: LoginPage(),
        ),
    '/perticuler-order/:orderid': (context, state, data) {
       final bookId = state.pathParameters['orderid']!;
      return MultiProvider(
          providers: [
            
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            ChangeNotifierProvider(create: (context) => UserDataGet()),
          ],
          child: OrderPerticuler(orderID: bookId,),
        );
    },
    '/add-team': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(create: (context) => createDio()),
            ProxyProvider<Dio, AddTeamApi>(
                update: (context, dio, apiService) =>
                    apiService ?? AddTeamApi(dio)),
            ProxyProvider<Dio, VentureService>(
              update: (context, dio, apiService) =>
                  apiService ?? VentureService(dio),
            ),
          ],
          child: TeamFromMain(),
        ),
    '/main': (context, state, data) {
      MainScreen();
    },
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
            ProxyProvider<Dio, UserApiService>(
              update: (context, dio, apiService) =>
                  apiService ?? UserApiService(dio),
            ),
          ],
          child: UsrMain(),
        ),
    '/user-add': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, UserService>(
              update: (context, dio, apiService) => apiService ?? UserService(),
            ),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, AddTeamApi>(
              update: (context, dio, apiService) =>
                  apiService ?? AddTeamApi(dio),
            ),
            ProxyProvider<Dio, RolesService>(
              update: (context, dio, apiService) =>
                  apiService ?? RolesService(dio),
            ),
            ProxyProvider<Dio, UserApiService>(
              update: (context, dio, apiService) =>
                  apiService ?? UserApiService(dio),
            ),
            ProxyProvider<Dio, FileUploadService>(
              update: (context, dio, apiService) =>
                  apiService ?? FileUploadService(dio),
            )
          ],
          child: UserAddMain(),
        ),
    '/client-list': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, ClientService>(
              update: (context, dio, apiService) =>
                  apiService ?? ClientService(dio),
            ),
          ],
          child: MainUSer(),
        ),
    '/client-add': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, ClientService>(
              update: (context, dio, apiService) =>
                  apiService ?? ClientService(dio),
            ),
          ],
          child: ClientAdd(),
        ),
    '/orders-list': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, OrderService>(
              update: (context, dio, apiService) =>
                  apiService ?? OrderService(dio),
            ),
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
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, VentureService>(
              update: (context, dio, apiService) =>
                  apiService ?? VentureService(dio),
            ),
          ],
          child: MainVentureAdd(),
        ),
    '/task-list': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, TaskApiService>(
              update: (context, dio, apiService) =>
                  apiService ?? TaskApiService(dio),
            ),
          ],
          child: TaskMain(),
        ),
    '/task-add': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
            Provider<Dio>(
              create: (context) => createDio(),
            ),
            ProxyProvider<Dio, AddTeamApi>(
              update: (context, dio, apiService) =>
                  apiService ?? AddTeamApi(dio),
            ),
            ProxyProvider<Dio, TaskApiService>(
              update: (context, dio, apiService) =>
                  apiService ?? TaskApiService(dio),
            ),
          ],
          child: TaskADD(),
        ),
  };
}

String appbaseUrl = "https://squid-app-3-s689g.ondigitalocean.app";
