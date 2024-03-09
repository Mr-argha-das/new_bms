import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/config/rolesmodel/roles.model.dart';
import 'package:admin/config/rolesservices/rolesservice.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/team/model/team.list.model.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:admin/screens/venture/user/model/user.add.res.dart';
import 'package:admin/screens/venture/user/service/user.api.service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:html' as html;

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final rmidController = TextEditingController();
  final symbolController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List _webImagePick = Uint8List(8);
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

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectFiles = _bytesData;
          // _pickedImage = File.;
          log("====================");
          // log(_pickedImage!.path.toString());
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  String? teamId;
  String? selectedRoleName;
  String? roleId;

  @override
  Widget build(BuildContext context) {
    final teamService = Provider.of<AddTeamApi>(context);
    final rolesService = Provider.of<RolesService>(context);
    Future<TeamListModel> data = getData(teamService);
    Future<RolesList> rolesData = getRoles(rolesService);
    final userService = Provider.of<UserApiService>(context);
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

        log(value.data[i].name);
      }
    });
    return Scaffold(
      body: items.isEmpty && rolesList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : pageLodar ? Center(
            child: CircularProgressIndicator(),
          ): Form(
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
                                "Add Users",
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        child: _bytesData == null
                                            ? Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Pick Profile Image"),
                                                ),
                                              )
                                            : Image.memory(
                                                _bytesData!,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          pageLodar = true;
                                        });
                                        log("/////////////////////////////");
                                        final addUserService =
                                            UserApiService(createDio());

                                        //  final fileUpload = FileUploadService(createDio());
                                        //  log("====================: 1");
                                        // //  final byteImage = await _pickedImage!.readAsBytes();
                                        final multipartFile =
                                            MultipartFile.fromBytes(_bytesData!,
                                                filename: "data.png");
                                        //   log("====================: 2");
                                        //  final data ={
                                        //    "images": multipartFile,
                                        //    "bucketName": "ahec"
                                        //  };
                                        //   log("====================: 3");
                                        // await fileUpload.upload( data: data);
                                        //  log("====================: 4");
                                        if (_formKey.currentState!.validate()) {
                                          final fileUploadService =
                                              FileUploadService(createDio());
                                          FileUploadResponse
                                              responseFileUpload =
                                              await fileUploadService.upload(
                                                  data: {
                                                "images": multipartFile,
                                                "bucketName": "ahec"
                                              });
                                          // final formData = {
                                          //   "roles": roleId,
                                          //   "name": nameController.text,
                                          //   "teams": teamId,
                                          //   "email": emailController.text,
                                          //   "number": mobileController.text,
                                          //   "password": mobileController.text,
                                          //   "image":
                                          //       "https://whale-app-9emyb.ondigitalocean.app/${responseFileUpload.data}"
                                          // };
                                          int number =
                                              int.parse(mobileController.text);
                                          AddUserModel formData = AddUserModel(
                                              image:
                                                  "https://ahec.diwamjewels.com/${responseFileUpload.data}",
                                              roles: roleId!,
                                              teams: teamId!,
                                              name: nameController.text,
                                              email: emailController.text,
                                              number: number,
                                              password: "$number");
                                          try{
                                             UserAddResponse response =
                                            await addUserService
                                                  .addUser(formData);
                                                  Beamer.of(context)
                                                .beamToNamed("/user-list");
                                          } catch(e, st){
                                          Beamer.of(context)
                                                .beamToNamed("/user-list");
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
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
    );
  }

  @override
  void dispose() {
    //profileBloc.dispose() cannot call as ProfileBloc class doesn't have dispose method
    super.dispose();
  }

  // void addUser(
  //     {required String roles,
  //     required String name,
  //     required String teams,
  //     required String email,
  //     required String number,
  //     required String password}) async {
  //   var request = http.MultipartRequest("POST",
  //       Uri.parse("https://squid-app-3-s689g.ondigitalocean.app/user-create"));
  //   request.headers["Access-Control-Allow-Origin"] = "*";
  //   request.headers["Access-Control-Allow-Credentials"] = "true";
  //   request.headers["Access-Control-Allow-Headers"] =
  //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
  //   request.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS";
  //   request.fields["roles"] = roles;
  //   request.fields["name"] = name;
  //   request.fields["teams"] = teams;
  //   request.fields["email"] = email;
  //   request.fields["number"] = number;
  //   request.fields["password"] = password;
  //   DateTime myFileDate = DateTime.now();
  //   request.files.add(await http.MultipartFile.fromBytes('image', _bytesData!,
  //       contentType: MediaType('application', 'json'),
  //       filename:
  //           "${myFileDate.day}_${myFileDate.month}_${myFileDate.year}_${myFileDate.second}${myFileDate.hour}"));

  //   request.send().then((response) {
  //     http.Response.fromStream(response).then((value) {
  //       log(value.body.toString());
  //     });
  //   });
  // }
}

class MyUploadImage {
  static Uint8List? bytesFromPicker;
}
