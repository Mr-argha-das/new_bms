import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/Clients/model/clientlistmodel.dart';
import 'package:admin/screens/Clients/service/client_api_service.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/add.order.body.model.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:admin/screens/orders/model/sharmodel.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddOrders extends StatefulWidget {
  const AddOrders({Key? key}) : super(key: key);

  @override
  State<AddOrders> createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
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

  String? filepath;
  String? imagepath;
  Uint8List? _bytesData;
  Uint8List? _images;
  List<int>? _selectFiles;
  final _fromKey = GlobalKey<FormState>();
  webFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      log("///////////////////////////");

      reader.onLoadEnd.listen((event) async {
        setState(() async {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectFiles = _bytesData;
          filepath = file.name;
          log("====================");
          // log(_pickedImage!.path.toString());
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  filePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      log("///////////////////////////");

      reader.onLoadEnd.listen((event) {
        setState(() async {
          _images =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectFiles = _bytesData;
          // _pickedImage = File.;
          imagepath = file.name;
          log("====================");
          // log(_pickedImage!.path.toString());
          final multipartFile =
              MultipartFile.fromBytes(_images!, filename: "${file.name}");
          final fileUploadService = FileUploadService(createDio());
          FileUploadResponse response = await fileUploadService
              .upload(data: {"images": multipartFile, "bucketName": "ahec"});
          imagepath = response.data;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  bool lodar = false;
  @override
  Widget build(BuildContext context) {
    final orderService = Provider.of<OrderService>(context);
    final clientservice = Provider.of<ClientService>(context);
    Future<ClientListModel> clientDatas = getClientList(clientservice);
    Future<Currencymodel> data = getData(orderService);
    Future<ServiceModel> service = getService(orderService);
    Future<AllocationListmodel> allocationData = getAllocation(orderService);
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
        body: items.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : lodar == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
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
                                "Create Orders",
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 600,
                                    width: 550,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/loda.gif"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MySearchapleDropDown(
                                            items: clientList,
                                            id: "",
                                            callBack: (value) {
                                              setState(() {
                                                clientId = value;
                                              });
                                            },
                                            title: "Search Client",
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MySearchapleDropDown(
                                            items: items,
                                            id: "",
                                            callBack: (value) {
                                              setState(() {
                                                currencyId = value;
                                              });
                                            },
                                            title: "Search Currency",
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  right: 8,
                                                  left: 8,
                                                  bottom: 8),
                                              child: Container(
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _inrTotalamountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Total Order Amount in INR",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _audTotalamountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Total Order Amount in AUD",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  right: 8,
                                                  left: 8,
                                                  bottom: 8),
                                              child: Container(
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _clientinrAmountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Client Paid Amount in INR",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _clientaudAmountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Client Paid Amount in AUD",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: MySearchapleDropDown(
                                            items: serviceList,
                                            id: "",
                                            callBack: (value) {
                                              setState(() {
                                                servicId = value;
                                              });
                                            },
                                            title: "Search Service",
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            right: 8,
                                            left: 8,
                                            bottom: 8),
                                        child: Container(
                                          height: 35,
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
                                                controller: _assignmentType,
                                                // keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  border: InputBorder.none,
                                                  hintText: "Assignment Type",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  right: 8,
                                                  left: 8,
                                                  bottom: 8),
                                              child: Container(
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _moduleCodeController,
                                                      // keyboardType: TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Module code",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _moduleNameController,
                                                      // keyboardType: TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Module name",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  pickDate =
                                                      (await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2030)))!;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          style: BorderStyle
                                                              .solid)),
                                                  child: Center(
                                                    child: pickDate != null
                                                        ? Text(
                                                            "${pickDate.day}-${pickDate.month}-${pickDate.year}")
                                                        : const Text(
                                                            "Select Deadline"),
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
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: TextFormField(
                                                      controller:
                                                          _wordCountController,
                                                      // keyboardType: TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Word count",
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: MySearchapleDropDown(
                                            items: _paymentType,
                                            id: "",
                                            callBack: (value) {
                                              setState(() {
                                                paymentType = value;
                                              });
                                            },
                                            title: "Select Payment Type",
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            right: 8,
                                            left: 8,
                                            bottom: 8),
                                        child: Container(
                                          height: 75,
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
                                                maxLines: 5,
                                                controller: _notesController,
                                                // keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  border: InputBorder.none,
                                                  hintText: "Notes",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                webFilePicker();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    right: 8,
                                                    left: 8,
                                                    bottom: 8),
                                                child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        239,
                                                        239,
                                                        239,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: filepath != null
                                                        ? Center(
                                                            child: Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .file_upload_outlined,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "upload any attachment",
                                                                style: GoogleFonts.montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          )),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                filePicker();
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12,
                                                              right: 8,
                                                              left: 8,
                                                              bottom: 8),
                                                      child: Container(
                                                        height: 35,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: imagepath != null
                                                            ? Center(
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Text(
                                                                  "Payment SS",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: SizedBox(width: 8))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            try{
                                              if (_fromKey.currentState!
                                                .validate()) {
                                              final multipartFile =
                                                  MultipartFile.fromBytes(
                                                      _bytesData!,
                                                      filename: "${filepath}");
                                              final multipartFile2 =
                                                  MultipartFile.fromBytes(
                                                      _images!,
                                                      filename: "${imagepath}");
                                              final fileUploadService =
                                                  FileUploadService(
                                                      createDio());
                                              FileUploadResponse response =
                                                  await fileUploadService
                                                      .upload(data: {
                                                "images": multipartFile,
                                                "bucketName": "ahec"
                                              });
                                              FileUploadResponse response2 =
                                                  await fileUploadService
                                                      .upload(data: {
                                                "images": multipartFile2,
                                                "bucketName": "ahec"
                                              });
                                              setState(() {
                                                filepath = response.data;
                                                imagepath = response2.data;
                                              });
                                              final getUserData = UserDataGet();
                                              getUserData.getUserLocalData();
                                              setState(() {
                                                lodar = true;
                                              });
                                              OrderAddResponse orderData = await orderService.addOrder(AddOrderBody(
                                                  orderNumber:
                                                      "${getUserData.name}-${currentDate.day}-${currentDate.month}-${currentDate.year}_${currentDate.hour}",
                                                  clientId: clientId!,
                                                  currencyId: currencyId!,
                                                  serviceId: servicId!,
                                                  inrAmmount: int.parse(
                                                      _inrTotalamountController
                                                          .text),
                                                  audAmmount: int.parse(
                                                      _audTotalamountController
                                                          .text),
                                                  clientAmmount: int.parse(
                                                      _clientaudAmountController
                                                          .text),
                                                  totalAmmount: int.parse(
                                                      _audTotalamountController
                                                          .text),
                                                  ppt: _assignmentType.text,
                                                  moduleCode:
                                                      _moduleCodeController.text,
                                                  moduleName: _moduleNameController.text,
                                                  deadline: "${pickDate.day}-${pickDate.month}-${pickDate.year}",
                                                  wordCount: _wordCountController.text,
                                                  paymentType: paymentType!,
                                                  shortNote: _notesController.text,
                                                  image: imagepath!,
                                                  file: filepath!,
                                                  userId: getUserData.id));
                                              final allocationService =
                                                  AllocationSerive(createDio());
                                              AllocationListmodel
                                                  allocationListmodel =
                                                  await allocationService
                                                      .getAllocationList();
                                              CreateSharReseModel
                                                  createSharReseModel =
                                                  await orderService.shareOrder(
                                                      CreateShareModel(
                                                          oderId: orderData.data
                                                              .oderDetails.id,
                                                          sendar:
                                                              getUserData.id,
                                                          receiver:
                                                              allocationListmodel
                                                                  .data[0].id,
                                                          status:
                                                              "Work Allocated",
                                                          message:
                                                              _notesController
                                                                  .text,
                                                          file: filepath!));

                                              Beamer.of(context)
                                                  .beamToNamed('/orders-list');
                                            }
                                            }catch(e){
                                             setState(() {
                                               lodar = false;
                                             });
                                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some thing Went Wrong")));
                                            }

                                            
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Submit",
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
