import 'dart:developer';

import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:beamer/beamer.dart';
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
                        (index) => userTable(

                          context,
                          count: index + 1,
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
  required String id,
  required int count,
  required String name,
  required String number,
  required String email,

}) {
  return DataRow(
    
    cells: [
      DataCell(
        Text(count.toString()),
      ),
      DataCell(Text(name)),
      DataCell(Text(email)),
      DataCell(Text(number)),
      DataCell(
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          constraints: BoxConstraints(minHeight: 100, minWidth: 20),
          color: const Color.fromARGB(255, 42, 46, 62),
          icon: Container(
            child: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
          onSelected: (String value) {
            // Handle menu item selection
            // You can add your logic here based on the selected value
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              padding: EdgeInsets.all(10),
              height: 25,
              child: Center(child: Icon(Icons.edit_outlined)),
            ),

            PopupMenuItem<String>(
              padding: EdgeInsets.all(10),
              height: 25,
              child: Center(child: Icon(Icons.file_open_outlined)),
            ),
            // Add more menu items as needed
          ],
        ),
      ),
    ],
  );
}
