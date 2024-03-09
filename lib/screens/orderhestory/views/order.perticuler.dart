import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class OrderPerticuler extends StatefulWidget {
  final String orderID;
  const OrderPerticuler({Key? key, required this.orderID}) : super(key: key);

  @override
  State<OrderPerticuler> createState() => _OrderPerticulerState();
}

class _OrderPerticulerState extends State<OrderPerticuler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(title: 'Perticuler Order', context: context),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(child: SideMenu(title: 'Perticuler Order', context: null)),
          Expanded(
              flex: 5,
              child: OrderPerticulerPageBody(
                orderID: widget.orderID,
              ))
        ],
      )),
    );
  }
}

class OrderPerticulerPageBody extends StatefulWidget {
  final String orderID;
  const OrderPerticulerPageBody({Key? key, required this.orderID})
      : super(key: key);

  @override
  State<OrderPerticulerPageBody> createState() =>
      _OrderPerticulerPageBodyState();
}

class _OrderPerticulerPageBodyState extends State<OrderPerticulerPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.edit),
        leading: GestureDetector(
          onTap: (){
            Beamer.of(context).beamToNamed('/orders-list');
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ListView.builder(itemBuilder: (context, index){
          return Card(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              child: ListTile(
               leading: Text("Allocation"),
               title: Text("Shift Date: 27-04-2005"),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}