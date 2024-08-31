import 'dart:developer';

import 'package:admin/config/coustom.button.dart';
import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/mytheme.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
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
            getUserData.getUserLocalData();
            launchUrl(Uri.parse(
                  "https://squid-app-3-s689g.ondigitalocean.app/user/${getUserData.id}/orders"));
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
  final List<PagesName> users;

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

String getValueBeforeDelimiter(String input, String delimiter) {
  // Split the input string by the delimiter
  List<String> parts = input.split(' |');
  // Return the first part (before the delimiter)
  return parts.isNotEmpty ? parts[0] : '';
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
                        CustomButton(path: "/add-order", title: "Order Add"),
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
                                flex: 1,
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
                                  "Crt. Date",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                            Expanded(
                                child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Deadline",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                            Expanded(
                                child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Current. WC",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                            Expanded(
                                child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text("Time",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Action",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      SizedBox(width: 15,)
                                    ],
                                  )
                                  
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
                                            : "-", deadline: '${snapshot.data!.data[index].deadline}', wordcount: '${snapshot.data!.data[index].wordCount}', time: '${snapshot.data!.data[index].shareStatus.isNotEmpty? snapshot.data!.data[index].shareStatus[0].time: "-"}',),
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
  final String deadline;
  final String wordcount;
  final String time;

  OrdersTab(
      {super.key,
      required this.no,
      required this.orderStatus,
      required this.createDate,
      required this.id,
      required this.orderNo,
      required this.deadline,
      required this.wordcount,
      required this.status, required this.time});

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
              width: 45,
            ),
            Expanded(
                child: Container(
              child: Text(
                getValueBeforeDelimiter(widget.orderNo, ' |'),
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )),
             SizedBox(width: 20,),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.createDate.toLocal().day.toString()}-${widget.createDate.toLocal().month}-${widget.createDate.toLocal().year}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 10,
            ),
            
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.deadline}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
            SizedBox(width: 20,),
            Expanded(
                child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.wordcount,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
            Expanded(
                child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.orderStatus,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.clock,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Beamer.of(context)
                            .beamToNamed('/copy-order/${widget.id}');
                          },
                          child: Icon(Icons.copy)),
                      ],
                    )
                  ),
              ],
            )),
          ],
        ),
    );
  }
}






        // SizedBox(
        //   height: 50,
        //   width: 400,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //         child: Text(
        //           widget.no.toString(),
        //           style: TextStyle(color: Colors.white, fontSize: 15),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 20,
        //       ),
        //       Expanded(
        //           flex: 3,
        //           child: SizedBox(
        //             child: Text(
        //               widget.orderNo,
        //               style: TextStyle(color: Colors.white, fontSize: 15),
        //             ),
        //           )),
        //       Expanded(
        //           child: SizedBox(
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             widget.status,
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       )),
        //       Expanded(
        //           child: GestureDetector(
        //               onTap: () {
        //                 Beamer.of(context)
        //                     .beamToNamed('/copy-order/${widget.id}');
        //               },
        //               child: Icon(Icons.copy))),
        //       Expanded(
        //           child: Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           SizedBox(
        //             width: 35,
        //           ),
        //           Expanded(
        //             child: Text(widget.orderStatus,
        //                 style: TextStyle(
        //                   fontSize: 14,
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.bold,
        //                 )),
        //           ),
        //         ],
        //       )),
        //     ],
        //   ))