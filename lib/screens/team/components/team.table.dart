import 'package:admin/constants.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/screens/team/model/team.list.model.dart';
import 'package:admin/screens/team/service/add_team_api.dart';
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
  
  Future<TeamListModel> getTeams(data) async {
    data = await data.getTeamList();
    return data;
  }

  Widget build(BuildContext context) {
    final teamService = Provider.of<AddTeamApi>(context);
    model = getTeams(teamService);

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
                      DataColumn(
                        label: Text("Status"),
                      ),
                    ],
                    rows: List.generate(
                      snapshot.data!.data.length,
                      (index) => teamTable(
                          id: snapshot.data!.data[index].id,
                          index: index + 1,
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
    {required int index,
    required String id,
    required String ventureName,
    required String teamType,
    required String name}) {
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
      )),
      DataCell(
        Container(
          height: 30,
          width: 80,
          child: LiteRollingSwitch(
            //initial value

            width: 90,
            value: true,
            textOn: 'ON',
            textOff: 'OFF',
            colorOn: bgColor,
            textOffColor: Colors.white,
            textOnColor: Colors.white,

            colorOff: Colors.red,
            iconOn: Icons.done,
            iconOff: Icons.remove_circle_outline,
            textSize: 10.0,
            onChanged: (bool state) {
              //Use it to manage the different states
              print('Current State of SWITCH IS: $state');
            },
            onSwipe: () {},
            onDoubleTap: () {},
            onTap: () {},
          ),
        ),
      )
    ],
  );
}
