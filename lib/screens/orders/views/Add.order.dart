import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;
import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/Clients/model/clientlistmodel.dart';
import 'package:admin/screens/Clients/service/client_api_service.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/existing.order.dart';
import 'package:admin/screens/orders/model/existing.order.res.dart';
import 'package:admin/screens/orders/model/orderlistmodel.dart';
import 'package:admin/screens/orders/model/payment.body.dart';
import 'package:admin/screens/orders/model/payment.create.res.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:admin/screens/orders/views/sharenoteaddorder.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddOrders extends StatefulWidget {
  const AddOrders({Key? key}) : super(key: key);

  @override
  State<AddOrders> createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
  final _trnxController = TextEditingController(text: "N/A");
  final _streamController = TextEditingController();
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
  final _topicController = TextEditingController();
  final _currentWordcountController = TextEditingController();
  final _totalInrAmmount = TextEditingController();
  final _clientpaidTotalAmountInr = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trnxController.text = "N/A";
  }

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
  final List<ItemClass> assignmentArray = [
    ItemClass(title: "Report", value: "Report"),
    ItemClass(title: "Report & PPT", value: "Report & PPT"),
    ItemClass(title: "Report & Practical", value: "Report & Practical"),
    ItemClass(title: "Practical", value: "Practical"),
    ItemClass(title: "PPT", value: "PPT"),
  ];
  final List<ItemClass> stream = [
    ItemClass(title: "Management", value: "Management"),
    ItemClass(title: "Technical", value: "Technical"),
    ItemClass(title: "Semi-Technica", value: "Semi-Technical"),
    ItemClass(title: "Finance", value: "Finance"),
    ItemClass(title: "Semi-Finance", value: "Semi-Finance"),
    ItemClass(title: "Law", value: "Law"),
    ItemClass(title: "Diploma", value: "Diploma"),
    ItemClass(title: "Bio", value: "Bio"),
    ItemClass(title: "Science", value: "Science"),
    ItemClass(title: "Diploma", value: "Diploma"),
    ItemClass(title: "Bio", value: "Bio"),
    ItemClass(title: "Science", value: "Science"),
    ItemClass(title: "Math", value: "Math"),
    ItemClass(title: "English Litrature", value: "English Litrature"),
  ];
  final List<ItemClass> clientList = [];
  final List<DataListModel> allocationList = [];
  List<ItemClass> orderlist = [];
  String? selectedValue;
  String? orderId;
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

  Future<OrderListModels> getClientOrderList(data) async {
    data = await data.getOrderListByUserId(clientId);
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

  String? existingorderid;
  bool lodar = false;
  String? orderType;
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
          // log(value.data[i].name);
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
        backgroundColor: secondaryColor,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MySearchapleDropDown(
                                                items: clientList,
                                                id: "",
                                                callBack: (value) {
                                                  setState(() {
                                                    orderlist = [];
                                                    clientId = value;
                                                  });
                                                  Future<OrderListModels>
                                                      ordersdata =
                                                      getClientOrderList(
                                                          orderService);
                                                  if (orderType == "2") {
                                                    ordersdata.then((value) {
                                                      for (int i = 0;
                                                          i < value.data.length;
                                                          i++) {
                                                        setState(() {
                                                          orderlist.addAll([
                                                            ItemClass(
                                                                title:
                                                                    "${value.data[i].orderNumber}",
                                                                value:
                                                                    "${value.data[i].id}")
                                                          ]);
                                                        });
                                                      }
                                                    });
                                                  }
                                                },
                                                title: "Search Client",
                                              )),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MySearchapleDropDown(
                                                items: [
                                                  ItemClass(
                                                      title: "New Order",
                                                      value: "1"),
                                                  ItemClass(
                                                      title: "Existing Order",
                                                      value: "2"),
                                                ],
                                                id: "",
                                                callBack: (value) {
                                                  setState(() {
                                                    orderlist = [];
                                                    orderType = value;
                                                  });
                                                  Future<OrderListModels>
                                                      ordersdata =
                                                      getClientOrderList(
                                                          orderService);
                                                  if (value == "2") {
                                                    ordersdata.then((value) {
                                                      for (int i = 0;
                                                          i < value.data.length;
                                                          i++) {
                                                        setState(() {
                                                          orderlist.addAll([
                                                            ItemClass(
                                                                title:
                                                                    "${value.data[i].orderNumber}",
                                                                value:
                                                                    "${value.data[i].id}")
                                                          ]);
                                                        });
                                                      }
                                                    });
                                                  } else {
                                                    setState(() {
                                                      currencyId = "";
                                                      servicId = "";
                                                      _clientaudAmountController
                                                          .text = "";
                                                      _inrTotalamountController
                                                          .text = "";
                                                      _audTotalamountController
                                                          .text = "";
                                                      _audTotalamountController
                                                          .text = "";
                                                      _assignmentType.text = "";
                                                      _moduleCodeController
                                                          .text = "";
                                                      _moduleNameController
                                                          .text = "";
                                                      _wordCountController
                                                          .text = "";
                                                      _totalInrAmmount.text =
                                                          "";
                                                      _currentWordcountController
                                                          .text = "";

                                                      _clientpaidTotalAmountInr
                                                          .text = "";
                                                    });
                                                  }
                                                },
                                                title: "Order type",
                                              )),
                                          if (orderType == "2") ...[
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: MySearchapleDropDown(
                                                  items: orderlist,
                                                  id: "",
                                                  callBack: (value) {
                                                    setState(() {
                                                      existingorderid = value;
                                                    });
                                                    Future<OrderListModels>
                                                        ordersdata =
                                                        getClientOrderList(
                                                            orderService);
                                                    ordersdata.then((value) {
                                                      setState(() {
                                                        currencyId = value
                                                            .data[0]
                                                            .currencyId
                                                            ?.id
                                                            .toString();
                                                        servicId = value.data[0]
                                                            .serviceId?.id
                                                            .toString();
                                                        _clientaudAmountController
                                                                .text =
                                                            value.data[0]
                                                                .clientAmmount
                                                                .toString();
                                                        _inrTotalamountController
                                                                .text =
                                                            value.data[0]
                                                                .inrAmmount
                                                                .toString();
                                                        _audTotalamountController
                                                                .text =
                                                            value.data[0]
                                                                .audAmmount
                                                                .toString();
                                                        _audTotalamountController
                                                                .text =
                                                            value.data[0]
                                                                .totalAmmount
                                                                .toString();
                                                        _assignmentType.text =
                                                            value.data[0].ppt;
                                                        _moduleCodeController
                                                                .text =
                                                            value.data[0]
                                                                .moduleCode;
                                                        _moduleNameController
                                                                .text =
                                                            value.data[0]
                                                                .moduleName;
                                                        _wordCountController
                                                                .text =
                                                            value.data[0]
                                                                .wordCount;
                                                        _totalInrAmmount.text =
                                                            value.data[0]
                                                                .totalInrAmmount;
                                                        _currentWordcountController
                                                                .text =
                                                            value.data[0]
                                                                .correntWordCount
                                                                .toString();

                                                        _clientpaidTotalAmountInr
                                                                .text =
                                                            value.data[0]
                                                                .clientPaidAmmountInr;
                                                        ValueHoldar
                                                                .clientpaidammountinr =
                                                            int.parse(value
                                                                .data[0]
                                                                .clientPaidAmmountInr);
                                                        ValueHoldar
                                                                .clientpaidammountAud =
                                                            int.parse(value
                                                                .data[0]
                                                                .clientAmmount);
                                                        orderId =
                                                            value.data[0].id;
                                                      });
                                                    });
                                                  },
                                                  title: "Search Client order",
                                                )),
                                          ],
                                          //
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          readOnly:
                                                              orderType == "2"
                                                                  ? true
                                                                  : false,
                                                          controller:
                                                              _inrTotalamountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Total Order Amount ",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          readOnly:
                                                              orderType == "2"
                                                                  ? true
                                                                  : false,
                                                          controller:
                                                              _totalInrAmmount,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Total Inr Amount",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          readOnly:
                                                              orderType == "2"
                                                                  ? true
                                                                  : false,
                                                          controller:
                                                              _audTotalamountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Total Order Amount in AUD",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _clientinrAmountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Client Paid Amount",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _clientpaidTotalAmountInr,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Client Paid Amount In inr",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _clientaudAmountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Client Paid Amount in AUD",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MySearchapleDropDown(
                                                items: items,
                                                id: "${currencyId ?? ""}",
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _moduleCodeController,
                                                          // keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Module code",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _moduleNameController,
                                                          // keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Module name",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MySearchapleDropDown(
                                                items: serviceList,
                                                id: "${servicId ?? ""}",
                                                callBack: (value) {
                                                  setState(() {
                                                    servicId = value;
                                                  });
                                                },
                                                title: "Search Service",
                                              )),
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            right: 8,
                                                            left: 8,
                                                            bottom: 8),
                                                    child: MySearchapleDropDown(
                                                      items: assignmentArray,
                                                      id: "",
                                                      callBack: (value) {
                                                        setState(() {
                                                          _assignmentType.text =
                                                              value;
                                                        });
                                                      },
                                                      title: "Assignment Type",
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            right: 8,
                                                            left: 8,
                                                            bottom: 8),
                                                    child: MySearchapleDropDown(
                                                      items: stream,
                                                      id: "",
                                                      callBack: (value) {
                                                        setState(() {
                                                          _streamController
                                                              .text = value;
                                                        });
                                                      },
                                                      title: "Stream",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
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
                                                        _topicController,
                                                    // keyboardType: TextInputType.number,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          "Topic / Company",
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

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime
                                                                      .now(),
                                                              lastDate:
                                                                  DateTime(
                                                                      2030)))!;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _wordCountController,
                                                          // keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Total Word count",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _currentWordcountController,
                                                          // keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Current Word count",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    webFilePicker();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            right: 8,
                                                            left: 8,
                                                            bottom: 8),
                                                    child: Container(
                                                        height: 40,
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
                                                                  .circular(10),
                                                        ),
                                                        child: filepath != null
                                                            ? Center(
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .green,
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
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 12,
                                                                  right: 8,
                                                                  left: 8,
                                                                  bottom: 8),
                                                          child: Container(
                                                            height: 38,
                                                            width:
                                                                MediaQuery.of(
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
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child:
                                                                imagepath !=
                                                                        null
                                                                    ? Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .done,
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                      )
                                                                    : Center(
                                                                        child:
                                                                            Text(
                                                                          "Payment SS",
                                                                          style: GoogleFonts.montserrat(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 8,
                                                          left: 8,
                                                          bottom: 8),
                                                  child: Container(
                                                    height: 35,
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
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 15),
                                                        child: TextFormField(
                                                          controller:
                                                              _trnxController,
                                                          // keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Trnx No.",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .montserrat(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (orderType != "2") {
                                                  try {
                                                    final getUserData =
                                                        UserDataGet();
                                                    getUserData
                                                        .getUserLocalData();
                                                    final allocationService =
                                                        AllocationSerive(
                                                            createDio());
                                                    AllocationListmodel
                                                        allocationListmodel =
                                                        await allocationService
                                                            .getAllocationList();
                                                    if (_fromKey.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        lodar = true;
                                                      });
                                                      final multipartFile =
                                                          MultipartFile.fromBytes(
                                                              _bytesData!,
                                                              filename:
                                                                  "${filepath}");
                                                      final multipartFile2 =
                                                          MultipartFile.fromBytes(
                                                              _images!,
                                                              filename:
                                                                  "${imagepath}");
                                                      final fileUploadService =
                                                          FileUploadService(
                                                              createDio());
                                                      FileUploadResponse
                                                          response =
                                                          await fileUploadService
                                                              .upload(data: {
                                                        "images": multipartFile,
                                                        "bucketName": "ahec"
                                                      });
                                                      FileUploadResponse
                                                          response2 =
                                                          await fileUploadService
                                                              .upload(data: {
                                                        "images":
                                                            multipartFile2,
                                                        "bucketName": "ahec"
                                                      });
                                                      setState(() {
                                                        filepath =
                                                            response.data;
                                                        imagepath =
                                                            response2.data;
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                              builder: (context) => ComposePAgeForAddOrder(
                                                                  trnx: _trnxController
                                                                      .text,
                                                                  stram: _streamController
                                                                      .text,
                                                                  topic: _topicController
                                                                      .text,
                                                                  currencyId:
                                                                      currencyId!,
                                                                  clientAmmount:
                                                                      int.parse(_clientaudAmountController
                                                                          .text),
                                                                  clientId:
                                                                      clientId!,
                                                                  servicId:
                                                                      servicId!,
                                                                  inrAmmount: int.parse(
                                                                      _inrTotalamountController
                                                                          .text),
                                                                  audAmmount: int.parse(
                                                                      _audTotalamountController
                                                                          .text),
                                                                  totalAmmount:
                                                                      int.parse(
                                                                          _audTotalamountController.text),
                                                                  ppt: _assignmentType.text,
                                                                  moduleCode: _moduleCodeController.text,
                                                                  moduleName: _moduleNameController.text,
                                                                  deadline: "${pickDate.day}-${pickDate.month}-${pickDate.year}",
                                                                  wordCount: _wordCountController.text,
                                                                  paymentType: paymentType!,
                                                                  images: imagepath!,
                                                                  file: filepath!,
                                                                  clientPaidAmmountInr: _clientpaidTotalAmountInr.text,
                                                                  totalInrAmmount: _totalInrAmmount.text,
                                                                  userid: getUserData.id,
                                                                  allocationId: allocationListmodel.data[0].id,
                                                                  currentWordcout: _currentWordcountController.text)));
                                                    }
                                                  } catch (e) {
                                                    setState(() {
                                                      lodar = false;
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Some thing Went Wrong")));
                                                  }
                                                } else {
                                                  setState(() {
                                                    lodar = true;
                                                  });
                                                  final getUserData =
                                                      UserDataGet();
                                                  getUserData
                                                      .getUserLocalData();
                                                  final orderService =
                                                      OrderService(createDio());
                                                  ExistingOrderResModel
                                                      responseData =
                                                      await orderService
                                                          .updateOrder(
                                                              "$orderId",
                                                              ExistingOrderModel(
                                                                clientAmmount: ValueHoldar
                                                                        .clientpaidammountAud +
                                                                    int.parse(
                                                                        _clientaudAmountController
                                                                            .text),
                                                                clientPaidAmmountInr: ValueHoldar
                                                                        .clientpaidammountinr +
                                                                    int.parse(
                                                                        _clientpaidTotalAmountInr
                                                                            .text),
                                                              ));
                                                  PaymentResponseModel
                                                      createpaymentrees =
                                                      await orderService.createPayment(
                                                          PaymentBodyModel(
                                                              orderId: orderId!,
                                                              userId:
                                                                  getUserData
                                                                      .id,
                                                              clientId:
                                                                  clientId!,
                                                              paymentType:
                                                                  paymentType!,
                                                              transactionId:
                                                                  _trnxController
                                                                      .text,
                                                              amount:
                                                                  _clientpaidTotalAmountInr
                                                                      .text));
                                                  Beamer.of(context)
                                                      .beamToNamed(
                                                          '/orders-list');
                                                }

                                                // try {
                                                //   if (_fromKey.currentState!
                                                //   .validate()) {
                                                // setState(() {
                                                //   lodar = true;
                                                // });

                                                // OrderAddResponse orderData = await orderService.addOrder(AddOrderBody(
                                                //     correntWordCount: _currentWordcountController.text,
                                                //     clientId: clientId!,
                                                //     currencyId: currencyId!,
                                                //     serviceId: servicId!,
                                                //     inrAmmount: int.parse(
                                                //         _inrTotalamountController
                                                //             .text),
                                                //     audAmmount: int.parse(
                                                //         _audTotalamountController
                                                //             .text),
                                                //     clientAmmount: int.parse(
                                                //         _clientaudAmountController
                                                //             .text),
                                                //     totalAmmount: int.parse(
                                                //         _audTotalamountController
                                                //             .text),
                                                //     ppt: _assignmentType.text,
                                                //     moduleCode:
                                                //         _moduleCodeController.text,
                                                //     moduleName: _moduleNameController.text,
                                                //     deadline: "${pickDate.day}-${pickDate.month}-${pickDate.year}",
                                                //     wordCount: _wordCountController.text,
                                                //     paymentType: paymentType!,
                                                //     shortNote: _notesController.text,
                                                //     image: imagepath!,
                                                //     file: filepath!,
                                                //     clientPaidAmmountInr: _clientpaidTotalAmountInr.text,
                                                //     userId: getUserData.id, total_inrAmmount: _totalInrAmmount.text));

                                                //     CreateSharReseModel
                                                //         createSharReseModel =
                                                //         await orderService.shareOrder(CreateShareModel(
                                                //           correntWordCount: _currentWordcountController.text,
                                                //             oderId: orderData.data
                                                //                 .oderDetails.id,
                                                //             sendar: getUserData.id,
                                                //             receiver:
                                                //                 allocationListmodel
                                                //                     .data[0].id,
                                                //             status:
                                                //                 "Work Allocated",
                                                //             message: _notesController
                                                //                 .text,
                                                //             file: filepath!,
                                                //             deadline:
                                                //                 '${pickDate.day}-${pickDate.month}-${pickDate.year}',
                                                //             topic: _topicController.text,
                                                //             word_count:
                                                //                 _wordCountController
                                                //                     .text));
                                                //     Beamer.of(context).beamToNamed(
                                                //         '/orders-list');
                                                //     log(createSharReseModel.message
                                                //         .toString());
                                                //   }
                                                // } catch (e) {
                                                //   setState(() {
                                                //     lodar = false;
                                                //   });
                                                //   ScaffoldMessenger.of(context)
                                                //       .showSnackBar(SnackBar(
                                                //           content: Text(
                                                //               "Some thing Went Wrong")));
                                                // }
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
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
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
                      ),
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

class ValueHoldar {
  static int clientpaidammountinr = 0;
  static int clientpaidammountAud = 0;
}
