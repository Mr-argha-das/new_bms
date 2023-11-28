import 'package:admin/constants.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';

import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

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
  Widget build(BuildContext context) {
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
            "Recent Files",
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
                demoRecentFiles.length,
                (index) => table(demoRecentFiles[index], index + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow table(RecentFile fileInfo, int index) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Text(index.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
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
