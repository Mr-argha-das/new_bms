import 'package:admin/config/pretty.dio.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/Clients/main.client.dart';
import 'package:admin/screens/Clients/views/Add.client.form.dart';
import 'package:admin/screens/Clients/views/list.main.dart';
import 'package:admin/screens/Task.add/AddToDotask.dart';
import 'package:admin/screens/Task.add/ToDotask.dart';
import 'package:admin/screens/Task.add/task.add.form.dart';
import 'package:admin/screens/dashboard/Profile_pages/profile.page.dart';
import 'package:admin/screens/loginpage/login.page.dart';
import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/main.orders.dart';
import 'package:admin/screens/orders/views/Add.order.dart';
import 'package:admin/screens/orders/views/Orders.chat.orders.list.dart';
import 'package:admin/screens/orders/views/chat.section.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/orders/views/orders.list.dart';
import 'package:admin/screens/team/main.team.dart';
import 'package:admin/screens/team/views/add.team.form.dart';
import 'package:admin/screens/team/views/team.list.dart';
import 'package:admin/screens/user/views/Add.user.form.page.dart';
import 'package:admin/screens/venture/main.venture.dart';

import 'package:admin/screens/venture/views/Add.Venture.Form.dart';
import 'package:admin/screens/venture/views/list.venture.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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
          child: ToDoTask(),
        ),
    '/dashboard': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController())
          ],
          child: MainScreen(),
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
  static String baseUrl = "https://squid-app-3-s689g.ondigitalocean.app";
}
