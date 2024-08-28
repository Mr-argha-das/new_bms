import 'dart:developer';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/mytheme.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/teams.user.model.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 33, 35, 50),
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
        floatingActionButton: GestureDetector(
          onTap: () async {
            final getUserData = UserDataGet();
            final orderService = OrderService(createDio());
            getUserData.getUserLocalData();
            if (getUserData.roleId == "6530f9f7023837a84d6f033c" ||
                getUserData.roleId == "66c738c66d763c91384bc395" ||
                getUserData.roleId == "66c738e3d2e9475afc5267db" ||
                getUserData.roleId == "65942790feeb0681fa958bd6" ||
                getUserData.roleId == "6594278bfeeb0681fa958bd3") {
              List<SastaLogic> userList = [];
              UserJoinTeamsModel teams =
                  await orderService.userTeams("${getUserData.id}");
              if (teams.data.teams.length != 0) {
                for (int i = 0; i < teams.data.teams.length; i++) {
                  TeamsUsers user =
                      await orderService.teamsUser("${teams.data.teams[i].id}");
                  userList.add(SastaLogic(index: i, users: user));
                }
              }

              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      height: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: ListView.builder(
                          itemCount: teams.data.teams.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                        "Team : ${teams.data.teams[index].name}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: userList[index].users.data.users.length,
                                    itemBuilder: (context, j){
                                    return GestureDetector(
                                      onTap: (){
                                        launchUrl(Uri.parse(
                  "https://squid-app-3-s689g.ondigitalocean.app/user/${userList[index].users.data.users[j].id}/orders"));
                                      },
                                      child: Text(
                                          "User : ${userList[index].users.data.users[j].name}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                    );
                                  })
                                ],
                              ),
                            );
                          },
                        ),
                      ));
                },
              );
            } else {
              launchUrl(Uri.parse(
                  "https://squid-app-3-s689g.ondigitalocean.app/user/${getUserData.id}/orders"));
            }
          },
          child: Container(
            height: 40,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text("Download"),
            ),
          ),
        ));
  }
}

class SastaLogic {
  final int index;
  final TeamsUsers users;

  SastaLogic({required this.index, required this.users});
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
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
  Future<OrderListModels>? model;
  Future<OrderListModels> getData() async {
    final orderService = Provider.of<OrderService>(context);
    final getUserData = UserDataGet();
    getUserData.getUserLocalData();
    final data = orderService.getOrderListByUserId(getUserData.id);
    return data;
  }

  Widget build(BuildContext context) {
    model = getData();
    return FutureBuilder<OrderListModels>(
        future: model,
        builder: (context, snapshot) {
          log("/////////////////////////////////////////////////////");

          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: MyTheme.tabscollor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 700,
                    width: 700,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('assets/images/Ellipse 3.png'),
                            fit: BoxFit.contain)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (snapshot.data?.data == null) ...[
                        Text("Recent Orders not found"),
                      ],
                      if (snapshot.data!.data.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            height: 45,
                            width: 1500,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "Sr no.",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        child: Text(
                                          "Order no.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Date / Time",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text("Action",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text("Status",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.30,
                          width: 1500,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: ListView.builder(
                                itemCount: snapshot.data!.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Beamer.of(context).beamToNamed()
                                      // "/order-status/${orders!.data[index].order.id}/${orders!.data[index].order.orderNumber}");
                                    },
                                    child: OrdersTab(
                                        orderStatus: snapshot.data!.data[index]
                                                    .shareStatus.length ==
                                                1
                                            ? snapshot.data!.data[index]
                                                .shareStatus[0].status
                                            : "-",
                                        no: index + 1,
                                        createDate: snapshot
                                            .data!.data[index].createdAt,
                                        id: snapshot.data!.data[index].id,
                                        orderNo: snapshot
                                            .data!.data[index].orderNumber,
                                        status: snapshot.data!.data[index]
                                                    .shareStatus.length ==
                                                1
                                            ? snapshot.data!.data[index]
                                                .shareStatus[0].time
                                            : " -"),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ],
                  )
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
    // onSelectChanged: (value) {
    //   Beamer.of(context).beamToNamed('/order-history/$orderid');
    // },
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
            // Icon(
            //   Icons.edit_outlined,
            //   color: Colors.white,
            // ),
            GestureDetector(
                onTap: () {
                  Beamer.of(context)
                      .beamToNamed('/order-status/$orderid/$orderNumber');
                },
                child: Icon(Icons.reply_all_sharp)),
            SizedBox(
              width: 20,
            ),

            GestureDetector(
                onTap: () {
                  Beamer.of(context).beamToNamed('/perticuler-order/$orderid');
                },
                child: Icon(CupertinoIcons.folder_circle)),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  Beamer.of(context).beamToNamed('/copy-order/$orderid');
                },
                child: Icon(Icons.copy))
          ],
        ),
      ),
    ],
  );
}

class OrdersTab extends StatefulWidget {
  final int no;
  final String orderStatus;
  final String id;
  final String status;
  final String orderNo;
  final DateTime createDate;

  OrdersTab(
      {super.key,
      required this.no,
      required this.orderStatus,
      required this.createDate,
      required this.id,
      required this.orderNo,
      required this.status});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  bool marked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Beamer.of(context)
            .beamToNamed('/order-status/${widget.id}/${widget.orderNo}');
      },
      child: SizedBox(
          height: 50,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  widget.no.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Text(
                      widget.orderNo,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )),
              Expanded(
                  child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.status,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Beamer.of(context)
                            .beamToNamed('/copy-order/${widget.id}');
                      },
                      child: Icon(Icons.copy))),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 35,
                  ),
                  Expanded(
                    child: Text(widget.orderStatus,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
