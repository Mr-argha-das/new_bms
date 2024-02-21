import 'dart:developer';

import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/currencymodel.dart';
import 'package:admin/screens/orders/model/service.model.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:flutter/material.dart';
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

  final List<ItemClass> items = [];
  final List<ItemClass> serviceList = [];
  String? selectedValue;
  Future<Currencymodel> getData(data) async {
    data = await data.getCurrency();
    return data;
  }

  Future<ServiceModel> getService(data) async {
   data = await data.getService();
   return data;
  }

  

  @override
  Widget build(BuildContext context) {
    final orderService = Provider.of<OrderService>(context);
    Future<Currencymodel> data = getData(orderService);
    Future<ServiceModel> service = getService(orderService);
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
    service.then((value){
    for (int i = 0; i <value.data.length; i++){
      if(value.data.length > serviceList.length){
        setState(() {
          serviceList.addAll([ItemClass(title: "${value.data[i].name}", value: value.data[i].id)]);
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
          : SingleChildScrollView(
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
                                  image: AssetImage("assets/images/loda.gif"),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 35,
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
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
                                                controller:
                                                    _clientnameController,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      "Client Name by State",
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
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MySearchapleDropDown(
                                      items: items,
                                      id: "",
                                      callBack: (value) {},
                                      title: "Search Currency",
                                    )),
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
                                                controller:
                                                    _inrTotalamountController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                                controller:
                                                    _audTotalamountController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                                controller:
                                                    _clientinrAmountController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                                controller:
                                                    _clientaudAmountController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: MySearchapleDropDown(
                                      items: serviceList,
                                      id: "",
                                      callBack: (value) {},
                                      title: "Search Service",
                                    )),
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
                                                controller:
                                                    _moduleCodeController,
                                                // keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                                controller:
                                                    _moduleNameController,
                                                // keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                                controller: _deadLineController,
                                                // keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  border: InputBorder.none,
                                                  hintText: "Dead line",
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
                                                controller:
                                                    _wordCountController,
                                                // keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration:
                                                    InputDecoration.collapsed(
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: MySearchapleDropDown(
                                      items: items,
                                      id: "",
                                      callBack: (value) {},
                                      title: "Select Payment Type",
                                    )),
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
                                          maxLines: 5,
                                          controller: _notesController,
                                          // keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          decoration: InputDecoration.collapsed(
                                            border: InputBorder.none,
                                            hintText: "Notes",
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.file_upload_outlined,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "upload any attachment",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12,
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
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Payment SS",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(child: SizedBox(width: 8))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20, color: Colors.white),
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
              ))
    );
  }
}
