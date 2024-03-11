import 'dart:convert';
import 'dart:developer';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/allocation/model/Allocation.add.model.dart';
import 'package:admin/screens/allocation/model/allocation.add.res.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

class AllocationAddBody extends StatefulWidget {
  const AllocationAddBody({Key? key}) : super(key: key);

  @override
  State<AllocationAddBody> createState() => _AllocationAddBodyState();
}

class _AllocationAddBodyState extends State<AllocationAddBody> {
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? filepath;
  String? imagepath;
  Uint8List? _bytesData;
  Uint8List? _images;
  List<int>? _selectFiles;
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

  bool lodar = false;

  @override
  Widget build(BuildContext context) {
    return lodar
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                          height: 550,
                          width: 1050,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Allocation",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 500,
                                          width: 600,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/Task.gif"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Please fill all field",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(height: 40),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() async {
                                                      webFilePicker();
                                                    });
                                                  },
                                                  child: filepath != null
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  239,
                                                                  239,
                                                                  239),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 80,
                                                          width: 300,
                                                          decoration: BoxDecoration(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  239,
                                                                  239,
                                                                  239),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          35,
                                                                      width: 50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: Colors.transparent),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.file_upload_outlined,
                                                                            color: const Color.fromARGB(
                                                                                255,
                                                                                24,
                                                                                102,
                                                                                179),
                                                                          ),
                                                                          Text(
                                                                            "Upload File",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 24, 102, 179)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Add Images",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ))
                                                              ],
                                                            ),
                                                          )),
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 45,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                239, 239, 239),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    nameController,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13),
                                                                decoration: InputDecoration.collapsed(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Name',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w300)),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                          .isEmpty ||
                                                                      value ==
                                                                          null) {
                                                                    return "This field required";
                                                                  }
                                                                },
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 45,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                239, 239, 239),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    emailController,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13),
                                                                decoration: InputDecoration.collapsed(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Email',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w300)),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                          .isEmpty ||
                                                                      value ==
                                                                          null) {
                                                                    return "This field required";
                                                                  }
                                                                },
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 239, 239, 239),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: TextFormField(
                                                            controller:
                                                                mobileNumberController,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                            decoration: InputDecoration.collapsed(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Mobile phone',
                                                                hintStyle: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                            validator: (value) {
                                                              if (value!
                                                                      .isEmpty ||
                                                                  value ==
                                                                      null) {
                                                                return "This field required";
                                                              }
                                                            },
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 45,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              239, 239, 239),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  passwordController,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13),
                                                              decoration: InputDecoration.collapsed(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      'Password',
                                                                  hintStyle: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                        .isEmpty ||
                                                                    value ==
                                                                        null) {
                                                                  return "This field required";
                                                                }
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        lodar = true;
                                                      });
                                                      final allocationService =
                                                          AllocationSerive(
                                                              createDio());
                                                      final multipartFile =
                                                          MultipartFile.fromBytes(
                                                              _bytesData!,
                                                              filename:
                                                                  "${filepath}");
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
                                                      AllocationAddResponse
                                                          allocationResponse =
                                                          await allocationService.addAllocation(AllocationAddModel(
                                                              name:
                                                                  nameController
                                                                      .text,
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              number:
                                                                  mobileNumberController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                              profilePic:
                                                                  response
                                                                      .data));
                                                      if (allocationResponse
                                                              .data ==
                                                          null) {
                                                        setState(() {
                                                          lodar = false;
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Some thing went wrong")));
                                                        });
                                                      } else {
                                                        Beamer.of(context)
                                                            .beamToNamed(
                                                                '/allocation-list');
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 41, 41, 41)),
                                                    child: Center(
                                                      child: Text(
                                                        "Submit",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ])))
                              ]))),
                ]));
  }
}
