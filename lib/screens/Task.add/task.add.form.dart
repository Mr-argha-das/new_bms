import 'dart:developer';

import 'package:admin/screens/Task.add/model/task.creat.model.dart';
import 'package:admin/screens/Task.add/service/TaskApiService.dart';
import 'package:admin/screens/team/model/team.list.model.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:beamer/beamer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class TaskAdd extends StatefulWidget {
  const TaskAdd({Key? key}) : super(key: key);

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  final List<String> items = [];
  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  final teamnameController = TextEditingController();
  final discriptionController = TextEditingController();
  final linkController = TextEditingController();
  Future<TeamListModel> getData(data) async {
    data = await data.getTeamList();
    return data;
  }

  String? teamId;
  @override
  Widget build(BuildContext context) {
    final teamService = Provider.of<AddTeamApi>(context);
    final taskService = Provider.of<TaskApiService>(context);
    Future<TeamListModel> data = getData(teamService);
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
    return items.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 600,
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
                                "Add Task",
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
                                          "assets/images/Add tasks.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
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
                                  "Please Fill Field",
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
                                          height: 50,
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
                                                      teamnameController,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: 'Task name',
                                                          hintStyle: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black,
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
                                                'Select Team',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: items
                                                  .map((String item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              ),
                                                            ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
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
                                                  controller: linkController,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Past Your Link',
                                                          hintStyle: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black,
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 239, 239),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        maxLines: 6,
                                        controller: discriptionController,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                        decoration: InputDecoration.collapsed(
                                            border: InputBorder.none,
                                            hintText: 'Discription',
                                            hintStyle: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300)),
                                        validator: (value) {
                                          if (value!.isEmpty || value == null) {
                                            return "This Field is required";
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      TaskCreateResponseModel response =
                                          await taskService.creatTask(
                                              TaskCreatBody(
                                                  gitSource:
                                                      linkController.text,
                                                  projectTudo:
                                                      teamnameController.text,
                                                  teamId: teamId!,
                                                  description:
                                                      discriptionController
                                                          .text));
                                      setState(() {
                                         Beamer.of(context)
                                            .beamToNamed('/task-list');
                                      });
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
}
