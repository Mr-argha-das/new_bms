import 'dart:developer';

import 'package:admin/screens/venture/model/model.dart';
import 'package:admin/screens/venture/service/api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddVenture extends StatefulWidget {
  const AddVenture({Key? key}) : super(key: key);

  @override
  State<AddVenture> createState() => _AddVentureState();
}

class _AddVentureState extends State<AddVenture> {
  final _formKey = GlobalKey<FormState>();
  final ventureName = TextEditingController();
  final ventureType = TextEditingController();

  Future<void> _showMyDialog({required String dataString}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$dataString'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Beamer.of(context).beamToNamed('/venture-list');
              },
            ),
          ],
        );
      },
    );
  }

  bool lodar = false;
  @override
  Widget build(BuildContext context) {
    final ventureService = Provider.of<VentureService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: lodar == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: 500,
                  width: 850,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Add Venture !",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ),
                          Container(
                              height: 400,
                              width: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Creative team (1).gif"),
                                    fit: BoxFit.cover,
                                  )))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 44,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "ADD Venture",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 239, 239, 239),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: TextFormField(
                                              controller: ventureName,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      border: InputBorder.none,
                                                      hintText: 'Venture Name',
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "This Field is Required";
                                                }
                                              },
                                            ),
                                          )
                                          // child: Text(
                                          //   "Venture Name",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       color: Colors.black,
                                          //       fontWeight: FontWeight.w300),
                                          // ),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 239, 239, 239),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: TextFormField(
                                              controller: ventureType,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      border: InputBorder.none,
                                                      hintText: 'Venture Type',
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "This Field is Required";
                                                }
                                              },
                                            ),
                                          )
                                          // child: Text(
                                          //   "Venture Type",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       color: Colors.black,
                                          //       fontWeight: FontWeight.w300),
                                          // ),
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            lodar = true;
                                          });

                                          VentureCreateResponse data =
                                              await ventureService
                                                  .ventureCreate(
                                                      VentureCreateField(
                                                          name:
                                                              ventureName.text,
                                                          type: ventureType
                                                              .text, status: true));
                                          log(data.message);
                                          if (data.status == false) {
                                            setState(() {
                                              lodar = false;
                                            });
                                            _showMyDialog(
                                                dataString:
                                                    data.message.toString());
                                          } else {
                                            Beamer.of(context)
                                                .beamToNamed('/venture-list');
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(
                                                255, 41, 41, 41)),
                                        child: Center(
                                          child: Text(
                                            "Submit",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ))
                    ],
                  )),
        ),
      ),
    );
  }
}
