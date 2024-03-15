import 'dart:developer';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/allocation/model/Allocation.add.model.dart';
import 'package:admin/screens/allocation/model/allocation.add.res.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllocationList extends StatefulWidget {
  const AllocationList({Key? key}) : super(key: key);

  @override
  State<AllocationList> createState() => _AllocationListState();
}

class _AllocationListState extends State<AllocationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            AllocationHeader(),
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
                      AllocationTable(),
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
          ],
        ),
      ),
    );
  }
}

class AllocationHeader extends StatefulWidget {
  const AllocationHeader({Key? key}) : super(key: key);

  @override
  State<AllocationHeader> createState() => _AllocationHeaderState();
}

class _AllocationHeaderState extends State<AllocationHeader> {
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
            "Allocation List",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),

        // ProfileCard()
      ],
    );
  }
}

class AllocationTable extends StatefulWidget {
  const AllocationTable({Key? key}) : super(key: key);

  @override
  State<AllocationTable> createState() => _AllocationTableState();
}

class _AllocationTableState extends State<AllocationTable> {
  Future<AllocationListmodel>? model;
  Future<AllocationListmodel> getData() async {
    final orderService = AllocationSerive(createDio());
    final data = orderService.getAllocationList();
    return data;
  }

  Widget build(BuildContext context) {
    model = getData();
    return FutureBuilder<AllocationListmodel>(
        future: model,
        builder: (context, snapshot) {
          log("/////////////////////////////////////////////////////");
          log(snapshot.data!.data.toString());
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("#"),
                        ),
                        DataColumn(
                          label: Text("Name"),
                        ),
                        DataColumn(
                          label: Text("Email"),
                        ),
                        DataColumn(
                          label: Text("Number"),
                        ),
                        DataColumn(
                          label: Text("Action"),
                        ),
                      ],
                      rows: List.generate(
                        snapshot.data!.data.length,
                        (index) => userTable(context,
                            count: index + 1,
                            callback: (){
                              setState(() {
                                 model = getData();
                              });
                            },
                            id: snapshot.data!.data[index].id,
                            name: snapshot.data!.data[index].name,
                            email: snapshot.data!.data[index].email,
                            number:
                                snapshot.data!.data[index].number.toString()),
                      ),
                    ),
                  ),
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
  required String id,
  required int count,
  required String name,
  required String number,
  required String email,
  required Function callback,
}) {
  return DataRow(
    cells: [
      DataCell(
        Text(count.toString()),
      ),
      DataCell(Text(name)),
      DataCell(Text(email)),
      DataCell(Text(number)),
      DataCell(GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AllocationUpdateForm(
                  callBack: callback,
                  id: id,
                  name: name,
                  email: email,
                  number: number,
                );
              },
            );
          },
          child: Icon(Icons.edit_outlined))),
    ],
  );
}

class AllocationUpdateForm extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final String number;
  final Function callBack;
  const AllocationUpdateForm(
      {Key? key,
      required this.id,
      required this.email,
      required this.name,
      required this.number,
      required this.callBack})
      : super(key: key);

  @override
  State<AllocationUpdateForm> createState() => _AllocationUpdateFormState();
}

class _AllocationUpdateFormState extends State<AllocationUpdateForm> {
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.email;
    nameController.text = widget.name;
    mobileNumberController.text = widget.number;
  }

  String? filepath;
  String? imagepath;
  Uint8List? _bytesData;
  Uint8List? _images;
  List<int>? _selectFiles;
  bool lodar = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24.withOpacity(0.1),
        ),
        child: Center(
          child: Container(
            height: 600,
            width: 800,
            decoration: BoxDecoration(
                color: Colors.white24.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)),
            child: Material(
              color: Colors.transparent,
              child: lodar
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Allocation Edit",
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
                                                          BorderRadius.circular(
                                                              30),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Please fill all field",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20),
                                                        ),
                                                        SizedBox(height: 40),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets.all(8.0),
                                                        //   child: GestureDetector(
                                                        //     onTap: () {
                                                        //       setState(() async {

                                                        //       });
                                                        //     },
                                                        //     child: filepath != null
                                                        //         ? Container(
                                                        //             decoration: BoxDecoration(
                                                        //                 color: const Color
                                                        //                     .fromARGB(
                                                        //                     255,
                                                        //                     239,
                                                        //                     239,
                                                        //                     239),
                                                        //                 borderRadius:
                                                        //                     BorderRadius
                                                        //                         .circular(
                                                        //                             25)),
                                                        //             child: Center(
                                                        //               child: Icon(
                                                        //                 Icons.done,
                                                        //                 color:
                                                        //                     Colors.green,
                                                        //               ),
                                                        //             ),
                                                        //           )
                                                        //         : Container(
                                                        //             height: 80,
                                                        //             width: 300,
                                                        //             decoration: BoxDecoration(
                                                        //                 color: const Color
                                                        //                     .fromARGB(
                                                        //                     255,
                                                        //                     239,
                                                        //                     239,
                                                        //                     239),
                                                        //                 borderRadius:
                                                        //                     BorderRadius
                                                        //                         .circular(
                                                        //                             25)),
                                                        //             child: Center(
                                                        //               child: Row(
                                                        //                 mainAxisAlignment:
                                                        //                     MainAxisAlignment
                                                        //                         .center,
                                                        //                 crossAxisAlignment:
                                                        //                     CrossAxisAlignment
                                                        //                         .center,
                                                        //                 children: [
                                                        //                   Expanded(
                                                        //                     child:
                                                        //                         Padding(
                                                        //                       padding:
                                                        //                           const EdgeInsets
                                                        //                               .all(
                                                        //                               8.0),
                                                        //                       child:
                                                        //                           Container(
                                                        //                         height:
                                                        //                             35,
                                                        //                         width: 50,
                                                        //                         decoration:
                                                        //                             BoxDecoration(
                                                        //                                 color: Colors.transparent),
                                                        //                         child:
                                                        //                             Row(
                                                        //                           mainAxisAlignment:
                                                        //                               MainAxisAlignment.center,
                                                        //                           crossAxisAlignment:
                                                        //                               CrossAxisAlignment.center,
                                                        //                           children: [
                                                        //                             Icon(
                                                        //                               Icons.file_upload_outlined,
                                                        //                               color: const Color.fromARGB(
                                                        //                                   255,
                                                        //                                   24,
                                                        //                                   102,
                                                        //                                   179),
                                                        //                             ),
                                                        //                             Text(
                                                        //                               "Upload File",
                                                        //                               style:
                                                        //                                   TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 24, 102, 179)),
                                                        //                             ),
                                                        //                           ],
                                                        //                         ),
                                                        //                       ),
                                                        //                     ),
                                                        //                   ),
                                                        //                   Expanded(
                                                        //                       child:
                                                        //                           Padding(
                                                        //                     padding:
                                                        //                         const EdgeInsets
                                                        //                             .all(
                                                        //                             8.0),
                                                        //                     child: Text(
                                                        //                       "Add Images",
                                                        //                       style: TextStyle(
                                                        //                           fontWeight:
                                                        //                               FontWeight
                                                        //                                   .bold,
                                                        //                           color: Colors
                                                        //                               .black),
                                                        //                     ),
                                                        //                   ))
                                                        //                 ],
                                                        //               ),
                                                        //             )),
                                                        //   ),
                                                        // ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  height: 45,
                                                                  width: 300,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          239,
                                                                          239,
                                                                          239),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Center(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              nameController,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 13),
                                                                          decoration: InputDecoration.collapsed(
                                                                              border: InputBorder.none,
                                                                              hintText: 'Name',
                                                                              hintStyle: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w300)),
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty ||
                                                                                value == null) {
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
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  height: 45,
                                                                  width: 300,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          239,
                                                                          239,
                                                                          239),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Center(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              emailController,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 13),
                                                                          decoration: InputDecoration.collapsed(
                                                                              border: InputBorder.none,
                                                                              hintText: 'Email',
                                                                              hintStyle: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w300)),
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty ||
                                                                                value == null) {
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
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 45,
                                                              width: 350,
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
                                                                              10)),
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Center(
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          mobileNumberController,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              13),
                                                                      decoration: InputDecoration.collapsed(
                                                                          border: InputBorder
                                                                              .none,
                                                                          hintText:
                                                                              'Mobile phone',
                                                                          hintStyle: TextStyle(
                                                                              fontSize: 13,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w300)),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!.isEmpty ||
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

                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Center(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                final allocationService =
                                                                    AllocationSerive(
                                                                        createDio());
                                                                AllocationAddResponse response = await allocationService.upadteAllocation(
                                                                    widget.id,
                                                                    AllocationUpdateModel(
                                                                        name: nameController
                                                                            .text,
                                                                        email: emailController
                                                                            .text,
                                                                        number:
                                                                            mobileNumberController.text));
                                                                widget
                                                                    .callBack();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            // onTap: () async {
                                                            //   if (_formKey.currentState!
                                                            //       .validate()) {
                                                            //     setState(() {
                                                            //       lodar = true;
                                                            //     });
                                                            //     final allocationService =
                                                            //         AllocationSerive(
                                                            //             createDio());
                                                            //     final multipartFile =
                                                            //         MultipartFile.fromBytes(
                                                            //             _bytesData!,
                                                            //             filename:
                                                            //                 "${filepath}");
                                                            //     final fileUploadService =
                                                            //         FileUploadService(
                                                            //             createDio());
                                                            //     FileUploadResponse
                                                            //         response =
                                                            //         await fileUploadService
                                                            //             .upload(data: {
                                                            //       "images": multipartFile,
                                                            //       "bucketName": "ahec"
                                                            //     });
                                                            //     AllocationAddResponse
                                                            //         allocationResponse =
                                                            //         await allocationService.addAllocation(AllocationAddModel(
                                                            //             name:
                                                            //                 nameController
                                                            //                     .text,
                                                            //             email:
                                                            //                 emailController
                                                            //                     .text,
                                                            //             number:
                                                            //                 mobileNumberController
                                                            //                     .text,
                                                            //             password:
                                                            //                 passwordController
                                                            //                     .text,
                                                            //             profilePic:
                                                            //                 response
                                                            //                     .data));
                                                            //     if (allocationResponse
                                                            //             .data ==
                                                            //         null) {
                                                            //       setState(() {
                                                            //         lodar = false;
                                                            //         ScaffoldMessenger.of(
                                                            //                 context)
                                                            //             .showSnackBar(SnackBar(
                                                            //                 content: Text(
                                                            //                     "Some thing went wrong")));
                                                            //       });
                                                            //     } else {
                                                            //       Beamer.of(context)
                                                            //           .beamToNamed(
                                                            //               '/allocation-list');
                                                            //     }
                                                            //   }
                                                            // },
                                                            child: Container(
                                                              height: 35,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          41,
                                                                          41,
                                                                          41)),
                                                              child: Center(
                                                                child: Text(
                                                                  "Submit",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
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
                          ])),
            ),
          ),
        ),
      ),
    );
  }
}
