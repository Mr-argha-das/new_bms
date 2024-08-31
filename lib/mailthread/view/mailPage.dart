import 'dart:convert';

import 'package:admin/config/env.dart';
import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/mytheme.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/mailthread/model/orderdetails.dart';
import 'package:admin/mailthread/model/payment.data.dart';

import 'package:admin/mailthread/model/status.model.dart';
import 'package:admin/mailthread/service/status.service.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:url_launcher/url_launcher.dart';

class MailThreadPage extends StatefulWidget {
  final String orderID;
  final String orderNo;
  const MailThreadPage({
    Key? key,
    required this.orderID,
    required this.orderNo,
  }) : super(key: key);

  @override
  State<MailThreadPage> createState() => _MailThreadPageState();
}

class _MailThreadPageState extends State<MailThreadPage> {
  late String orderid;
  @override
  void initState() {
    super.initState();
    orderid = widget.orderID;
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderNo),
        backgroundColor: MyTheme.tabscollor,
        leading: Container(),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyTheme.tabscollor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 200,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 220,
                          decoration: BoxDecoration(
                              color: index == 0
                                  ? Color.fromARGB(
                                      255,
                                      66,
                                      75,
                                      230,
                                    )
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.menu_open),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Order Details",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 220,
                          decoration: BoxDecoration(
                              color: index == 1
                                  ? Color.fromARGB(
                                      255,
                                      66,
                                      75,
                                      230,
                                    )
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.mail_outline_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mail Thread",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 220,
                          decoration: BoxDecoration(
                              color: index == 2
                                  ? Color.fromARGB(
                                      255,
                                      66,
                                      75,
                                      230,
                                    )
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.mail_outline_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Payments",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Beamer.of(context).beamToNamed("/orders-list");
                        },
                        child: Container(
                          height: 50,
                          width: 220,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.arrow_back),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Go Back",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),

            SizedBox(
              height: 50,
            ),
            if (index == 0) ...[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderDetailsSection(
                      orderid: widget.orderID,
                    ),
                  ))
            ],
            if (index == 1) ...[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MailThread(
                      orderNo: widget.orderNo,
                      orderID: widget.orderID,
                    ),
                  ))
            ],
            if (index == 2) ...[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PaymrntHestory(orderid: widget.orderID),
                  ))
            ]
          ],
        ),
      ),
    );
  }
}

class SideBard extends StatefulWidget {
  const SideBard({super.key});

  @override
  State<SideBard> createState() => _SideBardState();
}

class _SideBardState extends State<SideBard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: MyTheme.tabscollor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('assets/images/logo.png'),
                          fit: BoxFit.fitWidth)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: 220,
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                      255,
                      66,
                      75,
                      230,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.menu_open),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Order Details",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.mail_outline_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Mail Thread",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.chat_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMailTabs extends StatefulWidget {
  final String currentWordcount;
  final String status;
  final String message;
  final DateTime date;
  final String filePath;
  final String deadline;
  final String word_count;
  final String topic;
  final String orderNo;
  const MyMailTabs(
      {super.key,
      required this.currentWordcount,
      required this.date,
      required this.deadline,
      required this.topic,
      required this.word_count,
      required this.message,
      required this.orderNo,
      required this.status,
      required this.filePath});

  @override
  State<MyMailTabs> createState() => _MyMailTabsState();
}

class _MyMailTabsState extends State<MyMailTabs> {
  bool changeHeight = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            changeHeight = changeHeight ? false : true;
          });
        },
        child: AnimatedContainer(
          height: changeHeight ? 600 : 70,
          duration: Duration(milliseconds: 1),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Download File'),
                                  content: Text(
                                      'Do you want to download this file?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        launchUrl(Uri.parse(
                                            "https://work-pool.blr1.cdn.digitaloceanspaces.com/${widget.filePath}"));

                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text('Download'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text('Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.download,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.status +
                              " - Deadline : ${widget.deadline} - WordCount : ${widget.word_count} ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.date.day}-${widget.date.month}-${widget.date.year}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                CupertinoIcons.clock,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat('h:mm a').format(widget.date),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 10),
                                width: 20,
                                child: Center(
                                  child: Icon(
                                    changeHeight
                                        ? CupertinoIcons.arrowtriangle_down
                                        : CupertinoIcons.arrowtriangle_right,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (changeHeight == true) ...[
                Divider(
                  thickness: 0.2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Deadline : ${widget.deadline}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "WordCount : ${widget.word_count}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                       SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Current WC : ${widget.currentWordcount}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Topic / Company : ${widget.topic}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                        height: 7,
                      ),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "Details : ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                            child: HtmlWidget(
                          widget.message,
                          textStyle:
                              TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 0.2,
                  ),
                ),
                if (widget.filePath != "NONE") ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Download File'),
                                content:
                                    Text('Do you want to download this file?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      launchUrl(Uri.parse(
                                          "https://work-pool.blr1.cdn.digitaloceanspaces.com/${widget.filePath}"));

                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text('Download'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 120,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.file_copy_outlined,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 20,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      "${widget.date.day}-${widget.date.month}-${widget.date.year} : " +
                                          DateFormat('h:mm a')
                                              .format(widget.date),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingActionButtonWithText extends StatelessWidget {
  final String orderod;
  final String orderNo;
  final String wordcount;
  final String resiverId;
  final String topic;
  final String deadline;
  final String message;
  final String currentWordcount;
  FloatingActionButtonWithText(
      {Key? key,
      required this.currentWordcount,
      required this.message,
      required this.resiverId,
      required this.orderod,
      required this.orderNo,
      required this.deadline,
      required this.topic,
      required this.wordcount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Stack(
          children: [
            Container(
              height: 50,
              width: 150,
              child: FloatingActionButton(
                backgroundColor: Colors.indigoAccent,
                onPressed: () {
                  Beamer.of(context).beamToNamed(
                      "/compose/${orderod}/${topic}/${orderNo}/${wordcount}/${deadline}/NONE",
                      data: "$message");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Compose",
                      style: GoogleFonts.openSans(fontSize: 18),
                    ),
                  ],
                ), // Example icon, you can replace with your icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MailThread extends StatefulWidget {
  final String orderNo;
  final String orderID;
  const MailThread({super.key, required this.orderNo, required this.orderID});

  @override
  State<MailThread> createState() => _MailThreadState();
}

class _MailThreadState extends State<MailThread> {
  StatusListModel? status;
  List<StatusListModel> statusList = [];
  final getUserData = UserDataGet();
    
  Future<StatusListModel> fetchData() async {
    final statusService = StatusService(createDio());
    final data = await statusService.orderStatus(widget.orderID);
    return data;
  }

  Future<void> fetchOrderIdById() async {
    try {
      final statusService = StatusService(createDio());
      final data = await statusService.orderStatus(widget.orderID);

      data.data.forEach((item) {
        final orderId = item.oderId;
        final message = item.message;
        final createdAt = item.createdAt;
        print("Order ID: $orderId");
        print("message: $message");
        print("createdAt: $createdAt");
      });
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("INITIALIZATION PAGE");
    getUserData.getUserLocalData();
    // print(widget.orderno.toString());
    fetchOrderIdById();
  }

  @override
  Widget build(BuildContext context) {
    final data = fetchData();
    data.then((value) {
      setState(() {
        status = value;
      });
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: MyTheme.tabscollor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            /// paste here backgroung image
            Container(
              height: 700,
              width: 700,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('assets/images/Ellipse 3.png'),
                      fit: BoxFit.contain)),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: status?.data.length,
                  itemBuilder: (context, index) {
                    if (getUserData.id != status!.data[index].sendar || getUserData.id != status!.data[index].receiver){
                     return MyMailTabs(
                      word_count: status!.data[index].word_count,
                      deadline: status!.data[index].deadline,
                      topic: status!.data[index].topic,
                      date: status!.data[index].createdAt,
                      message: status!.data[index].message,
                      orderNo: widget.orderNo,
                      status: status!.data[index].status,
                      filePath: status!.data[index].file,
                      currentWordcount: status!.data[index].currentWordcount,
                    );
                    }else {
                      return SizedBox();
                    }
                    
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButtonWithText(
          currentWordcount:
              '${status!.data[status!.data.length - 1].currentWordcount}',
          message: '${status!.data[status!.data.length - 1].message}',
          resiverId: '${status!.data[status!.data.length - 1].sendar}',
          orderod: widget.orderID,
          orderNo: widget.orderNo,
          deadline: '${status!.data[status!.data.length - 1].deadline}',
          topic: '${status!.data[status!.data.length - 1].topic}',
          wordcount: '${status!.data[status!.data.length - 1].word_count}',
        ),
      ),
    );
  }
}

class OrderDetailsSection extends StatefulWidget {
  final String orderid;
  const OrderDetailsSection({super.key, required this.orderid});

  @override
  State<OrderDetailsSection> createState() => _OrderDetailsSectionState();
}

class _OrderDetailsSectionState extends State<OrderDetailsSection> {
  OrderDetailsModel? order;
  fetchorders() async {
    final orderDeatilsService = StatusService(createDio());
    OrderDetailsModel orderListModels =
        await orderDeatilsService.orderDetails(widget.orderid);

    setState(() {
      order = orderListModels;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("assets/images/Ellipse 3.png")),
          color: MyTheme.tabscollor,
          borderRadius: BorderRadius.circular(15)),
      child: order == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // MyField(
                        //   title: "Client",
                        //   value:
                        //       "${order!.data[0].clientId.name} (${order!.data[0].clientId.email})",
                        //   icon: Icon(
                        //     Icons.person_2_outlined,
                        //     color: Colors.white,
                        //   ),
                        // ),
                         MyField(
                          title: "Client",
                          value:
                              "${order!.data[0].clientId.name} (${order!.data[0].clientId.email})",
                          icon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Deadline",
                          value: "${order!.data[0].deadline}",
                          icon: Icon(
                            Icons.task,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // MyField(
                        //   title: "Client",
                        //   value:
                        //       "${order!.data[0].clientId.name} (${order!.data[0].clientId.email})",
                        //   icon: Icon(
                        //     Icons.person_2_outlined,
                        //     color: Colors.white,
                        //   ),
                        // ),
                         MyField(
                          title: "Stream",
                          value:
                              "${order!.data[0].stream}",
                          icon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Assignment Type",
                          value: "${order!.data[0].ppt}",
                          icon: Icon(
                            Icons.task,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyField(
                          title: "Module Code",
                          value: "${order!.data[0].moduleCode}",
                          icon: Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Module Name",
                          value: "${order!.data[0].moduleName}",
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyField(
                          title: "Total Word Count",
                          value: "${order!.data[0].wordCount}",
                          icon: Icon(
                            Icons.hourglass_empty_rounded,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Current Word Count",
                          value: "${order!.data[0].correntWordCount}",
                          icon: Icon(
                            Icons.hourglass_empty_rounded,
                            color: Colors.white,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyField(
                          title: "Total Order Amount in INR",
                          value: "${order!.data[0].totalInrAmmount}",
                          icon: Icon(
                            Icons.currency_rupee_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Total Order Amount in AUD",
                          value: "${order!.data[0].audAmmount}",
                          icon: Icon(
                            Icons.currency_bitcoin_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyField(
                          title: "Client Paid Amount in INR",
                          value: "${order!.data[0].clientPaidAmmountInr}",
                          icon: Icon(
                            Icons.currency_rupee_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Client Paid Amount in AUD",
                          value: "${order!.data[0].clientAmmount}",
                          icon: Icon(
                            Icons.currency_bitcoin_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 1500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyField(
                          title: "Currency",
                          value:
                              "${order!.data[0].currencyId?.symbol} ${order!.data[0].currencyId?.name}",
                          icon: Icon(
                            Icons.currency_exchange,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MyField(
                          title: "Payment Type",
                          value: "${order!.data[0].paymentType}",
                          icon: Icon(
                            Icons.payment,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class MyField extends StatefulWidget {
  final String title;
  final String value;
  final Icon icon;
  const MyField(
      {super.key,
      required this.title,
      required this.icon,
      required this.value});

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.title}",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                color: Colors.white.withOpacity(0.05),
                border: DashedBorder.fromBorderSide(
                  dashLength: 6,
                  side: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "${widget.value}",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.icon,
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatSection extends StatefulWidget {
  const ChatSection({super.key});

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("assets/images/Ellipse 3.png")),
            color: MyTheme.tabscollor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Chat With Team",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Hello",
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(500)),
                            child: Center(
                              child: Text(
                                "A",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(500)),
                            child: Center(
                              child: Text(
                                "A",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Hello",
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                })
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25, right: 15),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromARGB(225, 66, 75, 230),
              borderRadius: BorderRadius.circular(500)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(label: Text("Send a Message")),
                )),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PaymrntHestory extends StatefulWidget {
  final String orderid;
  const PaymrntHestory({super.key, required this.orderid});

  @override
  State<PaymrntHestory> createState() => _PaymrntHestoryState();
} 

class _PaymrntHestoryState extends State<PaymrntHestory> {
  Orderpaymenthestory? order;
  fetchorders() async {
    try{
     final orderDeatilsService = StatusService(createDio());
    Orderpaymenthestory orderListModels =
        await orderDeatilsService.getPaymenthetory(widget.orderid);

    setState(() {
      order = orderListModels;
    });
    } catch(e){
    setState(() {
      order = null;
    });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorders();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: MyTheme.tabscollor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            /// paste here backgroung image
            Container(
              height: 700,
              width: 700,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('assets/images/Ellipse 3.png'),
                      fit: BoxFit.contain)),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: order == null ? Center(
                child: Text("payments not found"),
              ) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: order?.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Center(
                            child: Text("${index+1}"),
                          )),
                          Expanded(child: Center(
                            child: Text("${order?.data[index].clientId.name} (${order?.data[index].clientId.email})"),
                          )),
                          Expanded(child: Center(
                            child: Text("${order?.data[index].transactionId}"),
                          )),
                          Expanded(child: Center(
                            child: Text("${order?.data[index].amount}"),
                          )),
                          Expanded(child: Center(
                            child: Text("${order?.data[index].createdAt.day}-${order?.data[index].createdAt.month}-${order?.data[index].createdAt.year}"),
                          )),
                        ],
                      ),
                    );
                    
                  },
                ),
              ),
            )
          ],
        ),
      ),
     
    );
  }
}