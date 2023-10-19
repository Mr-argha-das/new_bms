import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/Clients/main.client.dart';
import 'package:admin/screens/dashboard/Profile_pages/profile.page.dart';
import 'package:admin/screens/loginpage/login.page.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/main.orders.dart';
import 'package:admin/screens/team/main.team.dart';
import 'package:admin/screens/venture/main.venture.dart';
import 'package:provider/provider.dart';

class Env {
  static final appRoutes = {
    '/': (context, state, data) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController())
          ],
          child: LoginPage(),
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
    '/profile-user':(context, state, data) => MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MenuAppController()),
      
    ], child: ProfilePage(),)    
  };
  static String baseUrl = "https://squid-app-3-s689g.ondigitalocean.app";
}
