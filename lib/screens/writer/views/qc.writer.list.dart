import 'dart:developer';
import 'dart:math';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/writer/model/qc.writer.list.model.dart';
import 'package:admin/screens/writer/model/qc.writer.res.model.dart';
import 'package:admin/screens/writer/service/qc.writer.service.dart';
import 'package:beamer/beamer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QcWriterListPage extends StatefulWidget {
  const QcWriterListPage({Key? key}) : super(key: key);

  @override
  State<QcWriterListPage> createState() => _QcWriterListPageState();
}

class _QcWriterListPageState extends State<QcWriterListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 35, 50),
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
            "Qc Writer List",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
  Future<QcwritterListModel>? model;
  Future<QcwritterListModel> getData() async {
    final orderService = QcWriterService(createDio());
    final data = orderService.getQcWriterData();
    return data;
  }

  Widget build(BuildContext context) {
    model = getData();
    return FutureBuilder<QcwritterListModel>(
        future: model,
        builder: (context, snapshot) {
       
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
                          label: Text("Role"),
                        ),
                        DataColumn(
                          label: Text("Action"),
                        ),
                      ],
                      rows: List.generate(
                        snapshot.data!.data.length,
                        (index) => userTable(

                          context,
                          count: index + 1,
                          callBack: (){
                            setState(() {
                                model = getData();
                            });
                          },
                          role: snapshot.data!.data[index].roles,
                          allocationId: snapshot.data!.data[index].allocationId,
                          id: snapshot.data!.data[index].id,
                          name: snapshot.data!.data[index].name,
                          email: snapshot.data!.data[index].email,
                          number: snapshot.data!.data[index].number.toString()
                        ),
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
    required String allocationId,
  required String id,
  required Function callBack,
  required int count,
  required String name,
  required String number,
  required String email,
  required String role,

}) {
  return DataRow(
    
    cells: [
      DataCell(
        Text(count.toString()),
      ),
      DataCell(Text(name)),
      DataCell(Text(email)),
      DataCell(Text(number)),
      DataCell(Text(role)),
      DataCell(
        GestureDetector(
          onTap: (){
            showDialog(context: context, builder: (BuildContext context){
              return QcWriterEditForm(id: id, alloctionId: allocationId, email: email, name: name, number: number, callBack: callBack,);
            });
          },
          child: Icon(Icons.edit_outlined))
      ),
    ],
  );
}


class QcWriterEditForm extends StatefulWidget {
  final String id;
  final Function callBack;
  final String name;
  final String email;
  final String number;
  final String alloctionId;
  const QcWriterEditForm({Key? key, required this.id, required this.alloctionId, required this.callBack, required this.email, required this.name, required this.number}) : super(key: key);

  @override
  State<QcWriterEditForm> createState() => _QcWriterEditFormState();
}

class _QcWriterEditFormState extends State<QcWriterEditForm> {
    final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.email;
    nameController.text = widget.name;
    mobileController.text = widget.number;
    allocationID = widget.alloctionId;
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
    return allocation.isEmpty? Center(child: CircularProgressIndicator(),) : GestureDetector(
      onTap: (){
       Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24.withOpacity(0.1)
        ),
        child: Center(
          child: Container(
            height: 650,
            width: 800,
            decoration: BoxDecoration(
              color: Colors.white24.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)
            ),
            child: FutureBuilder<AllocationListmodel>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  lodar?  Center(
              child: CircularProgressIndicator(),
            ) :Scaffold(
              backgroundColor: Colors.white24.withOpacity(0.1),
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
                                      // Expanded(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Container(
                                      //       height: 35,
                                      //       width: 300,
                                      //       decoration: BoxDecoration(
                                      //           color: const Color.fromARGB(
                                      //               255, 239, 239, 239),
                                      //           borderRadius:
                                      //               BorderRadius.circular(10)),
                                      //       child: Padding(
                                      //           padding:
                                      //               const EdgeInsets.all(8.0),
                                      //           child: Center(
                                      //             child: TextFormField(
                                      //               controller:
                                      //                   passwordController,
                                      //               style: const TextStyle(
                                      //                   color: Colors.black,
                                      //                   fontSize: 13),
                                      //               decoration: const InputDecoration
                                      //                   .collapsed(
                                      //                   border:
                                      //                       InputBorder.none,
                                      //                   hintText: 'Password',
                                      //                   hintStyle: TextStyle(
                                      //                       fontSize: 13,
                                      //                       color: Colors.black,
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .w300)),
                                      //               validator: (value) {
                                      //                 if (value!.isEmpty ||
                                      //                     value == null) {
                                      //                   return "This Field is required";
                                      //                 }
                                      //               },
                                      //             ),
                                      //           )),
                                      //     ),
                                      //   ),
                                      // ),
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
                                        id: widget.alloctionId,
                                        callBack: (value) {
                                          setState(() {
                                            allocationID = value;
                                          });
                                        },
                                        title: "Select Allocation Type",
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      if(_formKey.currentState!.validate()){
                                        final qcwriterService = QcWriterService(createDio());
                                        QcwritterResModel response = await qcwriterService.updateQcWrite(widget.id, QcwritterUpdateModel(roles: selectedValue!, allocationId: allocationID!, name: nameController.text, email: emailController.text, number: mobileController.text));
                                        widget.callBack();
                                         Navigator.of(context).pop();
                                      }
                                    },
                                    child: Container(height: 50, decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(
                                      child: Text("Save"),
                                    ),
                                    ),
                                  )

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
        }),
          ),
        ),
      ),
    );
  }
}