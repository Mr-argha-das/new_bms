import 'dart:developer';

import 'package:admin/screens/team/model/team_response.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:admin/screens/venture/model/venture.list.model.dart';
import 'package:admin/screens/venture/service/api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VentureDropDown {
  final String name;
  final String vid;

  VentureDropDown({required this.name, required this.vid});
}

class AddTeamForm extends StatefulWidget {
  const AddTeamForm({Key? key}) : super(key: key);

  @override
  State<AddTeamForm> createState() => _AddTeamFormState();
}

class _AddTeamFormState extends State<AddTeamForm> {
  final List<String> items = [];
  String? selectedValue;
  String? ventureID;
  final teamtypeController = TextEditingController();
  final teamnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<VentureListModel> getData(data) async {
    data = await data.getVentureList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final ventureService = Provider.of<VentureService>(context);
    Future<VentureListModel> data = getData(ventureService);
    data.then((value) {
      for (int i = 0; i < value.data.length; i++) {
        if(value.data.length>items.length)
        setState(() {
          items.addAll([value.data[i].name]);
        });
        log(value.data[i].name);
      }
    });

    log(items.length.toString());
    final teamSerive = Provider.of<AddTeamApi>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: items.isEmpty
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
                      height: 600,
                      width: 1050,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text(
                                //   "Add Team",
                                //   style: GoogleFonts.montserrat(
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.black,
                                //     fontSize: 20,
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add Team",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 500,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Team work.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 40),
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
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: TextFormField(
                                                  controller:
                                                      teamnameController,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                    border: InputBorder.none,
                                                    hintText: 'Team name',
                                                    hintStyle: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty || value == null){
                                                     return "This feild is required";
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
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
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: TextFormField(
                                                  controller:
                                                      teamtypeController,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                    border: InputBorder.none,
                                                    hintText: 'Team type',
                                                    hintStyle: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if(value!.isEmpty || value == null){
                                                     return "This feild is required";
                                                    }
                                                  },
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
                                          DropdownButtonHideUnderline(
                                            
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              
                                              hint: Text(
                                                'Venture',
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
                                                           backgroundColor: Colors.white, 
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
                                                    for(int i =0; i<value2.data.length; i++){
                                                      if(value2.data[i].name == value){
                                                        ventureID = value2.data[i].id;
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
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: ()async {
                                      if(_formKey.currentState!.validate() && ventureID!=null){
                                       TeamResponse response = await teamSerive.login(TeamAddModel(name: teamnameController.text, type: teamtypeController.text, vId: ventureID!));
                                       if(response.status == true){
                                        Beamer.of(context).beamToNamed('/team-list');
                                       }
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Submit",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
