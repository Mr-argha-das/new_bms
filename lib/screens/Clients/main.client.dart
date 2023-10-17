


import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/Clients/views/list.main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainUSer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: context.read<MenuAppController>().scaffoldKey,
        drawer: SideMenu(title: 'Team', context: context,),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(title: 'Team', context: context,),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: ClientsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}