import 'package:admin/constants.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';

import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:admin/screens/venture/model/venture.list.model.dart';
import 'package:admin/screens/venture/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class VentureList extends StatefulWidget {
  const VentureList({Key? key}) : super(key: key);

  @override
  State<VentureList> createState() => _VentureListState();
}

class _VentureListState extends State<VentureList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            VentureHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      VentureTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class VentureTable extends StatefulWidget {
  const VentureTable({Key? key}) : super(key: key);

  @override
  State<VentureTable> createState() => _VentureTableState();
}

class _VentureTableState extends State<VentureTable> {
  @override
  Future<VentureListModel>? model;

  Future<VentureListModel> getVentureList(data) async {
    data = await data.getVentureList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final ventureServices = Provider.of<VentureService>(context);
    model = getVentureList(ventureServices);
    return FutureBuilder<VentureListModel>(
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
                  "Vinture List",
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
                        label: Text("Venture Type"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                      ),
                      DataColumn(
                        label: Text("Status"),
                      ),
                    ],
                    rows: List.generate(
                      snapshot.data!.data.length,
                      (index) => table(
                          id: snapshot.data!.data[index].id,
                          ventureName: snapshot.data!.data[index].name,
                          venturType: snapshot.data!.data[index].type,
                          index: index + 1),
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

DataRow table(
    {required String id,
    required String ventureName,
    required String venturType,
    required int index}) {
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
      DataCell(Text(venturType)),
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
