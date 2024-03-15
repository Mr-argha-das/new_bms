import 'dart:developer';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            OrdersHeader(),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: defaultPadding,
                      ),
                      OrdersTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(
                          height: defaultPadding,
                        )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    height: 45,
                    width: 380,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Pagination())
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OrdersHeader extends StatefulWidget {
  const OrdersHeader({Key? key}) : super(key: key);

  @override
  State<OrdersHeader> createState() => _OrdersHeaderState();
}

class _OrdersHeaderState extends State<OrdersHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Orders List",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        // ProfileCard()
      ],
    );
  }
}

// FutureBuilder<Album>(
//   future: futureAlbum,
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       return Text(snapshot.data!.title);
//     } else if (snapshot.hasError) {
//       return Text('${snapshot.error}');
//     }

//     // By default, show a loading spinner.
//     return const CircularProgressIndicator();
//   },
// )

class OrdersTable extends StatefulWidget {
  const OrdersTable({Key? key}) : super(key: key);

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  Future<OrderListModel>? model;
  Future<OrderListModel> getData() async {
    final orderService = Provider.of<OrderService>(context);
    final getUserData = UserDataGet();
    getUserData.getUserLocalData();
    final data = orderService.getOrderListByUserId(getUserData.id);
    return data;
  }

  Widget build(BuildContext context) {
    model = getData();
    return FutureBuilder<OrderListModel>(
        future: model,
        builder: (context, snapshot) {
          log("/////////////////////////////////////////////////////");
          log(snapshot.data!.data.toString());
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order List",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("#"),
                        ),
                        DataColumn(
                          label: Text("Orders Number"),
                        ),
                        DataColumn(
                          label: Text("Client Name"),
                        ),
                        DataColumn(
                          label: Text("Deadline"),
                        ),
                        DataColumn(
                          label: Text("Email"),
                        ),
                        DataColumn(
                          label: Text("Service"),
                        ),
                        DataColumn(
                          label: Text("Action"),
                        ),
                      ],
                      rows: List.generate(
                        snapshot.data!.data.length,
                        (index) => userTable(

                          context,
                          count: index + 1,
                          orderid: snapshot.data!.data[index].id,
                          orderNumber: snapshot.data!.data[index].orderNumber,
                          clienName: snapshot.data!.data[index].clientId.name,
                          deadline: snapshot.data!.data[index].deadline,
                          email: snapshot.data!.data[index].clientId.email,
                          service:
                              snapshot.data!.data[index].serviceId?.name ?? "-",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}

DataRow userTable(
  context, {
  required String orderid,
  required int count,
  required String orderNumber,
  required String clienName,
  required String deadline,
  required String email,
  required String service,
}) {
  return DataRow(
    onSelectChanged: (value){
      Beamer.of(context).beamToNamed('/perticuler-order/$orderid');
    },
    cells: [
      DataCell(
        Text(count.toString()),
      ),
      DataCell(Text(orderNumber)),
      DataCell(Text(clienName)),
      DataCell(Text(deadline)),
      DataCell(Text(email)),
      DataCell(Text(service)),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                Beamer.of(context).beamToNamed('/perticuler-order/$orderid');
              },
              child: Icon(Icons.file_open_outlined))
          ],
        )
        ,
      ),
    ],
  );
}
