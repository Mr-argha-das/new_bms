import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:admin/config/coustom.button.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/config/rolesservices/rolesservice.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/team/model/team.list.model.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:admin/screens/venture/user/model/User.list.model.dart';
import 'package:admin/screens/venture/user/service/user.api.service.dart';
import 'package:admin/screens/venture/user/service/user.service.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../config/rolesmodel/roles.model.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
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
            "User List",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        // ProfileCard()
      ],
    );
  }
}

class UserBody extends StatefulWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          UserHeader(),
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
                  UserTable(),
                  if (Responsive.isMobile(context))
                    SizedBox(
                      height: defaultPadding,
                    )
                ],
              ))
            ],
          )
        ],
      ),
    ));
  }
}

class UserTable extends StatefulWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  Future<UserListModel>? dataModel;

  @override
  void initState() {
    super.initState();
    final userapiService = UserApiService(createDio());

    dataModel = userapiService.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserListModel>(
      future: dataModel,
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
                CustomButton(path: "/user-add", title: "User Add"),
                Text(
                  "Emp List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    // minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text("#"),
                      ),
                      DataColumn(label: Text("Profile")),
                      DataColumn(
                        label: Text("User Name"),
                      ),
                      DataColumn(
                        label: Text("Phone"),
                      ),
                      DataColumn(
                        label: Text("Email"),
                      ),
                      DataColumn(
                        label: Text("Post"),
                      ),
                      DataColumn(
                        label: Text("Edit"),
                      ),
                    ],
                    rows: List.generate(
                      snapshot.data!.data.length,
                      (index) => userTable(context,
                          index: index + 1,
                          name: snapshot.data!.data[index].name!,
                          email: snapshot.data!.data[index].email!,
                          number: snapshot.data!.data[index].number.toString(),
                          rmid: "",
                          symbol: "",
                          teamName:
                              snapshot.data!.data[index].roles?.name ?? "-",
                          image: snapshot.data!.data[index].image!),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}

DataRow userTable(
  context, {
  required int index,
  required String name,
  required String email,
  required String image,
  required String number,
  required String teamName,
  required String rmid,
  required String symbol,
}) {
  return DataRow(
    cells: [
      DataCell(
        Text(index.toString()),
      ),
      DataCell(Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.fill),
            color: Colors.white,
            borderRadius: BorderRadius.circular(50)),
      )),
      DataCell(Text(name)),
      DataCell(Text(number)),
      DataCell(Text(email)),
      DataCell(Text(teamName)),
      DataCell(GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return UserUpdateSection(email: email, mobile: number, name: name, rmidController: rmid, symbol: symbol,);
            },
          );
        },
        child: Icon(
          Icons.copy,
          color: Colors.white,
        ),
      )),
    ],
  );
}

class UserUpdateSection extends StatefulWidget {
  final String name;
  final String email;
  final String mobile;
  final String rmidController;
  final String symbol;
  const UserUpdateSection({Key? key, required this.email, required this.mobile, required this.name, required this.rmidController, required this.symbol, }) : super(key: key);

  @override
  State<UserUpdateSection> createState() => _UserUpdateSectionState();
}

class _UserUpdateSectionState extends State<UserUpdateSection> {
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final rmidController = TextEditingController();
  final symbolController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List _webImagePick = Uint8List(8);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.email;
    mobileController.text = widget.mobile;
    nameController.text = widget.name;
    rmidController.text = widget.rmidController;
    symbolController.text = widget.symbol;
  }
  final List<String> items = [];
  final List<String> rolesList = [];
  String? selectedValue;
  Image? bytesFromPicker;
  List<int>? _selectFiles;
  Uint8List? _bytesData;
  bool pageLodar = false;
  Future<TeamListModel> getData(data) async {
    data = await data.getTeamList();
    return data;
  }

  Future<RolesList> getRoles(data) async {
    data = await data.getRolesList();
    return data;
  }
  String? teamId;
  String? selectedRoleName;
  String? roleId;

  @override
  Widget build(BuildContext context) {
    final teamService = AddTeamApi(createDio());
    final rolesService = RolesService(createDio());
    Future<TeamListModel> data = getData(teamService);
    Future<RolesList> rolesData = getRoles(rolesService);
    final userService = UserApiService(createDio());
    rolesData.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > rolesList.length) {
          setState(() {
            rolesList.addAll([value.data[i].name]);
          });
        }
      }
    });
    data.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if (value.data.length > items.length) {
          setState(() {
            items.addAll([value.data[i].name]);
          });
        }

      }
    });
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24.withOpacity(0.1),
        ),
        child: Center(
          child: items.isEmpty && rolesList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : pageLodar ? Center(
            child: CircularProgressIndicator(),
          ): Material(
            color: Colors.white24.withOpacity(0.1)
            ,
            child: Center(
              child: Form(
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
                                    "Edit Users",
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
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/Add User.gif"),
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
                                    SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration.collapsed(
                                                              border:
                                                                  InputBorder.none,
                                                              hintText: 'Name',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      Colors.black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
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
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration.collapsed(
                                                              border:
                                                                  InputBorder.none,
                                                              hintText: 'Email',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      Colors.black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
                                                    ),
                                                  )),
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
                                                      controller: rmidController,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration.collapsed(
                                                              border:
                                                                  InputBorder.none,
                                                              hintText: 'RMID',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      Colors.black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
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
                                              // width: 300,
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
                                                      controller: symbolController,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration.collapsed(
                                                              border:
                                                                  InputBorder.none,
                                                              hintText: 'Symbol',
                                                              hintStyle: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      Colors.black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                                controller: mobileController,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        border: InputBorder.none,
                                                        hintText: 'Mobile number',
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w300)),
                                              ),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 239, 239, 239),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Role',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  items: rolesList
                                                      .map((String item) =>
                                                          DropdownMenuItem<String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors.black,
                                                                backgroundColor:
                                                                    Colors.white,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: selectedRoleName,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      selectedRoleName = value;
                                                      rolesData.then((value2) {
                                                        for (int i = 0;
                                                            i < value2.data.length;
                                                            i++) {
                                                          if (value2.data[i].name ==
                                                              value) {
                                                            roleId =
                                                                value2.data[i].id;
                                                          }
                                                        }
                                                      });
                                                    });
                                                  },
                                                  buttonStyleData: ButtonStyleData(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                    height: 35,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                  iconStyleData: IconStyleData(
                                                    iconEnabledColor: Colors.black,
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 239, 239, 239),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Teams',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  items: items
                                                      .map((String item) =>
                                                          DropdownMenuItem<String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors.black,
                                                                backgroundColor:
                                                                    Colors.white,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: selectedValue,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      selectedValue = value;
                                                      data.then((value2) {
                                                        for (int i = 0;
                                                            i < value2.data.length;
                                                            i++) {
                                                          if (value2.data[i].name ==
                                                              value) {
                                                            teamId =
                                                                value2.data[i].id;
                                                          }
                                                        }
                                                      });
                                                    });
                                                  },
                                                  buttonStyleData: ButtonStyleData(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                    height: 35,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                  iconStyleData: IconStyleData(
                                                    iconEnabledColor: Colors.black,
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
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         webFilePicker();
                                    //       },
                                    //       child: Container(
                                    //         height: 100,
                                    //         width: 100,
                                    //         decoration: BoxDecoration(
                                    //           color: Colors.grey.shade400,
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ),
                                    //         child: _bytesData == null
                                    //             ? Center(
                                    //                 child: Padding(
                                    //                   padding:
                                    //                       const EdgeInsets.all(8.0),
                                    //                   child: Text(
                                    //                       "Pick Profile Image"),
                                    //                 ),
                                    //               )
                                    //             : Image.memory(
                                    //                 _bytesData!,
                                    //                 fit: BoxFit.fill,
                                    //               ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 100,
                                    //     ),
                                    //     GestureDetector(
                                    //       onTap: () async {
                                    //         setState(() {
                                    //           pageLodar = true;
                                    //         });
                                           
                                    //         final addUserService =
                                    //             UserApiService(createDio());
              
                                    //         //  final fileUpload = FileUploadService(createDio());
                                    //         //  log("====================: 1");
                                    //         // //  final byteImage = await _pickedImage!.readAsBytes();
                                    //         final multipartFile =
                                    //             MultipartFile.fromBytes(_bytesData!,
                                    //                 filename: "data.png");
                                    //         //   log("====================: 2");
                                    //         //  final data ={
                                    //         //    "images": multipartFile,
                                    //         //    "bucketName": "ahec"
                                    //         //  };
                                    //         //   log("====================: 3");
                                    //         // await fileUpload.upload( data: data);
                                    //         //  log("====================: 4");
                                    //         // if (_formKey.currentState!.validate()) {
                                    //         //   final fileUploadService =
                                    //         //       FileUploadService(createDio());
                                    //         //   FileUploadResponse
                                    //         //       responseFileUpload =
                                    //         //       await fileUploadService.upload(
                                    //         //           data: {
                                    //         //         "images": multipartFile,
                                    //         //         "bucketName": "ahec"
                                    //         //       });
                                    //         //   // final formData = {
                                    //         //   //   "roles": roleId,
                                    //         //   //   "name": nameController.text,
                                    //         //   //   "teams": teamId,
                                    //         //   //   "email": emailController.text,
                                    //         //   //   "number": mobileController.text,
                                    //         //   //   "password": mobileController.text,
                                    //         //   //   "image":
                                    //         //   //       "https://whale-app-9emyb.ondigitalocean.app/${responseFileUpload.data}"
                                    //         //   // };
                                    //         //   int number =
                                    //         //       int.parse(mobileController.text);
                                    //         //   AddUserModel formData = AddUserModel(
                                    //         //       image:
                                    //         //           "https://ahec.diwamjewels.com/${responseFileUpload.data}",
                                    //         //       roles: roleId!,
                                    //         //       teams: teamId!,
                                    //         //       name: nameController.text,
                                    //         //       email: emailController.text,
                                    //         //       number: number,
                                    //         //       password: "$number");
                                    //         //   try{
                                    //         //      UserAddResponse response =
                                    //         //     await addUserService
                                    //         //           .addUser(formData);
                                    //         //           Beamer.of(context)
                                    //         //         .beamToNamed("/user-list");
                                    //         //   } catch(e, st){
                                    //         //   Beamer.of(context)
                                    //         //         .beamToNamed("/user-list");
                                    //         //   }
                                              
                                    //         // }
                                    //       },
                                    //       child: Container(
                                    //         height: 40,
                                    //         width: 150,
                                    //         decoration: BoxDecoration(
                                    //             color: Colors.black,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(15)),
                                    //         child: Center(
                                    //           child: Text("Submit",
                                    //               style: GoogleFonts.montserrat(
                                    //                   color: Colors.white,
                                    //                   fontWeight: FontWeight.bold)),
                                    //         ),
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                    SizedBox(
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
            ),
          ),
        ),
      ),
    );
  }
}

// 9005771245
// sneha.burman.uhub@gmail.com