import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          "Order History",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Beamer.of(context).beamToNamed('/orders-list');
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ListView.builder(itemBuilder: (context, index) {
          return Tabs();
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
  bool isopen = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isopen = !isopen;
          });
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          height: isopen ? 150 : 50,
          duration: Duration(milliseconds: 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: Text(
                    "Allocation:",
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    "Shift Date: 27-04-2005",
                    style: GoogleFonts.montserrat(color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Card(
                    color: Colors.white,
                    elevation: 1,
                     child: Container(
                      height: 90,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Click to Download", 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        ),
                      )
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                      height: 80,
                      width: 1,
                      decoration: BoxDecoration(color: Colors.black),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Short Note here", style: TextStyle(color: Colors.black),),
                   )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
