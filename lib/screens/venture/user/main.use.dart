import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/Clients/views/Add.client.form.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/venture/user/views/Add.user.form.page.dart';
import 'package:admin/screens/venture/user/views/list.user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsrMain extends StatefulWidget {
  const UsrMain({Key? key}) : super(key: key);

  @override
  State<UsrMain> createState() => _UsrMainState();
}

class _UsrMainState extends State<UsrMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: context.read<MenuAppController>().scaffoldKey,
        drawer: SideMenu(
          title: 'Team',
          context: context,
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(
                    title: 'Team',
                    context: context,
                  ),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: UserBody(),
              ),
            ],
          ),
        ));
  }
}
class UserAddMain extends StatefulWidget {
  const UserAddMain({Key? key}) : super(key: key);

  @override
  State<UserAddMain> createState() => _UserAddMainState();
}

class _UserAddMainState extends State<UserAddMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: context.read<MenuAppController>().scaffoldKey,
        drawer: SideMenu(
          title: 'Team',
          context: context,
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(
                    title: 'Team',
                    context: context,
                  ),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: AddUserForm(),
              ),
            ],
          ),
        ));
  }
}
