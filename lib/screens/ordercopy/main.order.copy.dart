import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/ordercopy/views/order.copy.page.dart';
import 'package:admin/screens/orders/views/Add.order.dart';
import 'package:admin/screens/orders/views/orders.list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainOrderCopy extends StatefulWidget {
  final String orderID;
  const MainOrderCopy({Key? key, required this.orderID}) : super(key: key);

  @override
  State<MainOrderCopy> createState() => _MainOrderCopyState();
}

class _MainOrderCopyState extends State<MainOrderCopy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  context: null,
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: OrderCopy(orderID: widget.orderID,),
            ),
          ],
        ),
      ),
    );
  }
}


