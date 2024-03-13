import 'dart:developer';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/team/model/team.list.model.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
import 'package:admin/screens/venture/model/venture.list.model.dart';
import 'package:admin/screens/venture/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class TeamTable extends StatefulWidget {
  const TeamTable({Key? key}) : super(key: key);

  @override
  State<TeamTable> createState() => _TeamTableState();
}

class _TeamTableState extends State<TeamTable> {
  @override
  Future<TeamListModel>? model;
  Future<VentureListModel>? ventureListData;
  List<ItemClass> venturelist = [];
  Future<TeamListModel> getTeams(data) async {
    data = await data.getTeamList();
    return data;
  }
  Future<VentureListModel> getVentureListdata(data) async {
    data = await data.getVentureList();
    return data;
  }

  Widget build(BuildContext context) {
    final teamService = Provider.of<AddTeamApi>(context);
    final ventureService = VentureService(createDio());
    ventureListData = getVentureListdata(ventureService);
    model = getTeams(teamService);
    ventureListData!.then((value){
      for(int i = 0; i < value.data.length; i++){
        if(value.data.length > venturelist.length){
          setState(() {
             venturelist.addAll([ItemClass(title: value.data[i].name, value: value.data[i].id)]);
            
          });
        }
      }
     
    });

    return FutureBuilder<TeamListModel>(
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
                Text(
                  "Team List",
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
                      DataColumn(
                        label: Text("Venture Name"),
                      ),
                      DataColumn(
                        label: Text("Team Name"),
                      ),
                      DataColumn(
                        label: Text("Team Type"),
                      ),
                      DataColumn(
                        label: Text("Action "),
                      ),
                      // DataColumn(
                      //   label: Text("Status"),
                      // ),
                    ],
                    rows: List.generate(
                      snapshot.data!.data.length,
                      (index) => teamTable(
                        context,
                          id: snapshot.data!.data[index].id,
                          ventureList: venturelist,
                          ventureid: snapshot.data!.data[index].vId!.id,
                          index: index + 1,
                          callBack2: (){
                            setState(() {
                               model = getTeams(teamService);
                            });
                          },
                          ventureName: snapshot.data!.data[index].vId!.name,
                          teamType: snapshot.data!.data[index].type,
                          name: snapshot.data!.data[index].name),
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









DataRow teamTable(
  context,
    {required int index,
    required String id,
    required String ventureName,
    required String ventureid,
    required String teamType,
    required String name,
    required Function callBack2,
    required List<ItemClass> ventureList,
    })  {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Text(index.toString()),
          ],
        ),
      ),
      DataCell(Text(ventureName)),
      DataCell(Text(name)),
      DataCell(Text(teamType)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                final teamNameController = TextEditingController(text: name);
                final teamTypeController = TextEditingController(text: teamType);
                String? ventureIDSelect;
                log(ventureid);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: (){
                           Navigator.of(context).pop();
                        },
                        child: Container(
                        
                          decoration: BoxDecoration(
                            color: Colors.white24.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Container(
                              height: 300,
                              width: 400,
                              decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(15)),
                              child: Material(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextField(
                                        controller: teamNameController,
                                        decoration: InputDecoration(
                                          label: Text("Team Name"),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.white, width: 1)
                                          )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: teamTypeController,
                                        decoration: InputDecoration(
                                          label: Text("Team Type"),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.white, width: 1)
                                          )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                     
                                      GestureDetector(
                                        onTap: ()async{
                                          final service = AddTeamApi(createDio());
                                          TeamUpdateResModel response = await service.updateTeamData(id, TeamAddModel(name: teamNameController.text, type: teamTypeController.text, vId: ventureid));
                                           Navigator.of(context).pop();
                                           callBack2();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Center(
                                            child: Text("Save"),
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
                    },
                  );
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4, 4))
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      
    ],
  );
}
