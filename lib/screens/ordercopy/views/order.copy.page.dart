import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/Clients/model/clientlistmodel.dart';
import 'package:admin/screens/Clients/service/client_api_service.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/add.order.body.model.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderCopy extends StatefulWidget {
  final String orderID;
  const OrderCopy({Key? key,required this.orderID}) : super(key: key);

  @override
  State<OrderCopy> createState() => _OrderCopyState();
}

class _OrderCopyState extends State<OrderCopy> {
  final _clientnameController = TextEditingController();
  final _inrTotalamountController = TextEditingController();
  final _audTotalamountController = TextEditingController();
  final _clientinrAmountController = TextEditingController();
  final _clientaudAmountController = TextEditingController();
  final _moduleCodeController = TextEditingController();
  final _moduleNameController = TextEditingController();
  final _deadLineController = TextEditingController();
  final _wordCountController = TextEditingController();
  final _notesController = TextEditingController();
  final _assignmentType = TextEditingController();
  String? allocationId;
  String? clientId;
  String? currencyId;
  String? servicId;
  String? paymentType;
  DateTime pickDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  final List<ItemClass> items = [];
  final List<ItemClass> serviceList = [];
  final List<ItemClass> _paymentType = [
    ItemClass(title: "Full Payment", value: "FullPayment"),
    ItemClass(title: "Partially Payment", value: "PartiallyPayment"),
    ItemClass(title: "Renaming Payment", value: "RenamingPayment"),
  ];
  OrderListModel? orderDetails;
  Future<OrderListModel> orderDetailsGet(){
    final orderService = OrderService(createDio());
    final response = orderService.getOrderListByUserId(widget.orderID.toString());
    return response;
  }
  final List<ItemClass> clientList = [];
  final List<DataListModel> allocationList = [];
  String? selectedValue;
  Future<Currencymodel> getData(data) async {
    data = await data.getCurrency();
    return data;
  }

  Future<ServiceModel> getService(data) async {
    data = await data.getService();
    return data;
  }

  Future<AllocationListmodel> getAllocation(data) async {
    data = await data.getAllocvationList();
    return data;
  }

  Future<ClientListModel> getClientList(data) async {
    final getUserData = UserDataGet();
    getUserData.getUserLocalData();
    data = await data.getClientList(getUserData.id);
    return data;
  }


  List<int>? _selectFiles;
  final _fromKey = GlobalKey<FormState>();
  

  
 

  bool lodar = false;
  @override
  Widget build(BuildContext context) {
    final orderService = OrderService(createDio());
    final clientservice = ClientService(createDio());
    Future<ClientListModel> clientDatas = getClientList(clientservice);
    Future<Currencymodel> data = getData(orderService);
    Future<ServiceModel> service = getService(orderService);
    Future<AllocationListmodel> allocationData = getAllocation(orderService);
    Future<OrderListModel> orderDetailsFirst = orderDetailsGet();
    orderDetailsFirst.then((value){
    setState(() {
       orderDetails = value;
         _audTotalamountController.text = orderDetails!.data[0].audAmmount.toString();
    _inrTotalamountController.text = orderDetails!.data[0].inrAmmount.toString();
    _clientaudAmountController.text = orderDetails!.data[0].clientAmmount.toString();
    _clientinrAmountController.text = orderDetails!.data[0].totalAmmount.toString();
    _assignmentType.text = orderDetails!.data[0].ppt;
    _moduleCodeController.text = orderDetails!.data[0].moduleCode;
    _moduleNameController.text = orderDetails!.data[0].moduleName;
    _notesController.text = orderDetails!.data[0].shortNote;
    _wordCountController.text = orderDetails!.data[0].wordCount;
    });
    });
    clientDatas.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > clientList.length) {
          setState(() {
            clientList.addAll([
              ItemClass(
                  title: "${value.data[i].name} (${value.data[i].email})",
                  value: value.data[i].id)
            ]);
          });
        }
      }
    });
    allocationData.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > items.length) {
          log(value.data[i].name);
          setState(() {
            allocationList.addAll([
              DataListModel(
                  name: value.data[i].name,
                  email: value.data[i].email,
                  value: value.data[i].id)
            ]);
          });
        }
      }
    });
    data.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > items.length) {
          log(value.data[i].name);
          setState(() {
            items.addAll([
              ItemClass(
                  title: "${value.data[i].name} ${value.data[i].symbol}",
                  value: value.data[i].id)
            ]);
          });
        }
      }
    });
    service.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > serviceList.length) {
          setState(() {
            serviceList.addAll([
              ItemClass(title: "${value.data[i].name}", value: value.data[i].id)
            ]);
          });
        }
      }
    });
   
    return Scaffold(
        backgroundColor: Colors.white,
        body: items.isEmpty || orderDetails == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : lodar==true?  Center(
              child: CircularProgressIndicator(),
            ) : SingleChildScrollView(
                child: Form(
                  key: _fromKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 25, bottom: 15),
                          child: Text(
                            "Orders Details",
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0x542A2E3E),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue: "(${orderDetails!.data[0].clientId.name}) ${orderDetails!.data[0].clientId.email}",
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                         label: Text("Client", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Total Order Amount in INR",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue: "${orderDetails!.data[0].currencyId!.symbol} ${orderDetails!.data[0].currencyId!.name}",
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Currency", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Total Order Amount in INR",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _inrTotalamountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Total Order Amount in INR", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Total Order Amount in INR",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _audTotalamountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Total Order Amount in AUD", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    
                                                    hintText:
                                                        "Total Order Amount in AUD",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _clientinrAmountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Client Paid Amount in INR", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Client Paid Amount in INR",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _clientaudAmountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Client Paid Amount in AUD", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Client Paid Amount in AUD",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue: "${orderDetails!.data[0].serviceId!.name}",
                                                  keyboardType:
                                                      TextInputType.number,
                                                      
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Service Type", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    
                                                    hintText:
                                                        "Total Order Amount in INR",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 8, left: 8, bottom: 8),
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          239,
                                          239,
                                          239,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8, left: 15),
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: _assignmentType,
                                            // keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            decoration: InputDecoration(
                                              label: Text("Assignment Type", style: TextStyle(color: Colors.black),),
                                              border: InputBorder.none,
                                              hintText: "Assignment Type",
                                              hintStyle: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _moduleCodeController,
                                                  // keyboardType: TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                         label: Text("Module code", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText: "Module code",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _moduleNameController,
                                                  // keyboardType: TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                         label: Text("Module Name", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText: "Module name",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: InkWell(
                                            onTap: () async {
                                             
                                            },
                                            child: Container(
                                              height: 40,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      style: BorderStyle.solid)),
                                              child: Center(
                                                child: Text(
                                                        orderDetails!.data[0].deadline)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 8, left: 15),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      _wordCountController,
                                                  // keyboardType: TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration:
                                                      InputDecoration(
                                                        label: Text("Word count", style: TextStyle(color: Colors.black),),
                                                    border: InputBorder.none,
                                                    hintText: "Word count",
                                                    hintStyle:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 8, left: 8, bottom: 8),
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          239,
                                          239,
                                          239,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8, left: 15),
                                          child: TextFormField(
                                            readOnly: true,
                                            initialValue: orderDetails!.data[0].paymentType,
                                            // keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            decoration: InputDecoration(
                                              label: Text("Payment Type", style: TextStyle(color: Colors.black),),
                                              border: InputBorder.none,
                                              hintText: "Assignment Type",
                                              hintStyle: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 8, left: 8, bottom: 8),
                                    child: Container(
                                      height: 75,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          239,
                                          239,
                                          239,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8, left: 15),
                                          child: TextFormField(
                                            readOnly: true,
                                            maxLines: 5,
                                            controller: _notesController,
                                            // keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Notes",
                                              label: Text("Notes", style: TextStyle(color: Colors.black),),
                                              hintStyle: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        
                                        // mysastalogic(callBack: (value) {
                                        //   setState(() {
                                        //     allocationId = value;
                                        //   });
                                        // });
                                        
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Click To Copy",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                                ),
                )));
  }

  void mysastalogic({required Function callBack}) {
    log(allocationList.length.toString());
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Allocation Team To send Order",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                allocationList.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: allocationList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                callBack(allocationList[index].value);
                                Navigator.pop(context);
                              },
                              child: Card(
                                color: allocationId == null
                                    ? Colors.white
                                    : allocationId ==
                                            allocationList[index].value
                                        ? Colors.blue
                                        : Colors.white,
                                child: ListTile(
                                  title: Text(
                                    "Allocation: ${allocationList[index].name}",
                                    style: GoogleFonts.montserrat(
                                      color: allocationId == null
                                          ? Colors.black
                                          : allocationId ==
                                                  allocationList[index].value
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Email:  ${allocationList[index].email}",
                                    style: GoogleFonts.montserrat(
                                      color: allocationId == null
                                          ? Colors.black
                                          : allocationId ==
                                                  allocationList[index].value
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
              ],
            ),
          ),
        );
      },
    );
  }
}

class DataListModel {
  final String name;
  final String email;
  final String value;

  DataListModel({required this.name, required this.email, required this.value});
}
