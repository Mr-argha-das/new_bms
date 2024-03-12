import 'dart:convert';
import 'dart:developer';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/writer/model/qc.writer.add.model.dart';
import 'package:admin/screens/writer/model/qc.writer.res.model.dart';
import 'package:admin/screens/writer/service/qc.writer.service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

class QcAndWriterAdd extends StatefulWidget {
  const QcAndWriterAdd({Key? key}) : super(key: key);

  @override
  State<QcAndWriterAdd> createState() => _QcAndWriterAddState();
}

class _QcAndWriterAddState extends State<QcAndWriterAdd> {
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  Datum? allocationBValue;
  final List<String> items = ['QC', 'Writer'];
  final List<String> allocationList = ['Satpal', 'Rajat'];
  String? allocationID;
  String? filepath;
  String? imagepath;
  Uint8List? _bytesData;
  Uint8List? _images;
  List<int>? _selectFiles;
  Future<AllocationListmodel>? model;
  Future<AllocationListmodel> getData() async {
    final orderService = AllocationSerive(createDio());
    final data = orderService.getAllocationList();
    return data;
  }
  bool lodar = false;

  List<ItemClass> allocation = [];
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

  @override
  Widget build(BuildContext context) {
    model = getData();
    model!.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > allocation.length) {
          setState(() {
            allocation.addAll([
              ItemClass(title: value.data[i].name, value: value.data[i].id)
            ]);
          });
        }
      }
    });
    return FutureBuilder<AllocationListmodel>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  lodar?  Center(
              child: CircularProgressIndicator(),
            ) :Scaffold(
              body: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
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
                                  "Add Qc Writer",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 500,
                                        width: 600,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    const Positioned.fill(
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/Notebook.gif"),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Please fill all field",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 35,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 239, 239, 239),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: TextFormField(
                                                    controller: nameController,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                    decoration:
                                                        const InputDecoration
                                                            .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'Name',
                                                            hintStyle: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                    validator: (value) {
                                                      if (value!.isEmpty ||
                                                          value == null) {
                                                        return "This Field is required";
                                                      }
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 35,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 239, 239, 239),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: TextFormField(
                                                    controller: emailController,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                    decoration:
                                                        const InputDecoration
                                                            .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: 'Email',
                                                            hintStyle: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                    validator: (value) {
                                                      if (value!.isEmpty ||
                                                          value == null) {
                                                        return "This Field is required";
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 35,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 239, 239, 239),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: TextFormField(
                                                    controller:
                                                        passwordController,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                    decoration: const InputDecoration
                                                        .collapsed(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Password',
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                    validator: (value) {
                                                      if (value!.isEmpty ||
                                                          value == null) {
                                                        return "This Field is required";
                                                      }
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 35,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 239, 239, 239),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        mobileController,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                    decoration:
                                                        const InputDecoration
                                                            .collapsed(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Mobile number',
                                                            hintStyle: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                    validator: (value) {
                                                      if (value!.isEmpty ||
                                                          value == null) {
                                                        return "This Field is required";
                                                      }
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 239, 239, 239),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton2<String>(
                                                      isExpanded: true,
                                                      hint: const Text(
                                                        'Role',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      items: items
                                                          .map((String item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value: selectedValue,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          selectedValue = value;
                                                        });
                                                      },
                                                      buttonStyleData:
                                                          ButtonStyleData(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                        ),
                                                        height: 35,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      iconStyleData:
                                                          const IconStyleData(
                                                        iconEnabledColor:
                                                            Colors.black,
                                                      ),
                                                      menuItemStyleData:
                                                          const MenuItemStyleData(
                                                        height: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MySearchapleDropDown(
                                        items: allocation,
                                        id: "",
                                        callBack: (value) {
                                          setState(() {
                                            allocationID = value;
                                          });
                                        },
                                        title: "Select Payment Type",
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            webFilePicker();
                                          },
                                          child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: filepath != null
                                                  ? Center(
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                      ),
                                                    )
                                                  :
                                                  // _bytesData == null
                                                  //     ?
                                                  const Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            "Pick Profile Image"),
                                                      ),
                                                    )
                                              // : Image.memory(
                                              //     _bytesData!,
                                              //     fit: BoxFit.fill,
                                              //   ),
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                                  setState(() {
                                                    lodar = true;
                                                  });
                                              final multipartFile =
                                                  MultipartFile.fromBytes(
                                                      _bytesData!,
                                                      filename: "${filepath}");
                                              final fileUploadService =
                                                  FileUploadService(
                                                      createDio());
                                              FileUploadResponse response =
                                                  await fileUploadService
                                                      .upload(data: {
                                                "images": multipartFile,
                                                "bucketName": "ahec"
                                              });
                                              final qcWriterService =
                                                  QcWriterService(createDio());
                                              
                                              try{
                                               QcwritterResModel resModel =
                                                  await qcWriterService.adQcWriter(
                                                      QcwritteraddModel(
                                                          roles: selectedValue!,
                                                          allocationId:
                                                              allocationID!,
                                                          name: nameController
                                                              .text,
                                                          email: emailController
                                                              .text,
                                                          number:
                                                              mobileController
                                                                  .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                          profile:
                                                              response.data));
                                                               Beamer.of(context).beamToNamed('/list-writer-qc');

                                              } catch (e){
                                               setState(() {
                                                    lodar = false;
                                                  });
                                                  Future.delayed(Duration(seconds: 2));
                                                final scaffoldMessenger =
                                                    ScaffoldMessenger.of(
                                                        context);
                                                scaffoldMessenger
                                                    .showMaterialBanner(
                                                  MaterialBanner(
                                                    backgroundColor: Colors.white,
                                                    content: Text(
                                                        "This is number or email already exist."),
                                                    actions: [Container()],
                                                  ),
                                                );
                                                Future.delayed(
                                                    const Duration(seconds: 4),
                                                    () {
                                                  scaffoldMessenger
                                                      .hideCurrentMaterialBanner();
                                                });
                                              }
                                              
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text("Submit",
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some Thing went wrong"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
