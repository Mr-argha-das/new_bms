import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/venture/user/views/Add.user.form.page.dart';
import 'package:admin/screens/venture/views/Add.Venture.Form.dart';
import 'package:admin/screens/venture/views/list.venture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainVenture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(title: 'Venture', context: context,),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(title: 'Venture', context: context,),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: VentureList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MainVentureAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(title: 'Venture', context: context,),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(title: 'Venture', context: context,),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: AddVenture(),
            ),
          ],
        ),
      ),
    );
  }
}