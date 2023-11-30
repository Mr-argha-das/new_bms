import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            OrdersHeader(),
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
                      OrdersTable(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    height: 45,
                    width: 380,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Pagination())
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OrdersHeader extends StatefulWidget {
  const OrdersHeader({Key? key}) : super(key: key);

  @override
  State<OrdersHeader> createState() => _OrdersHeaderState();
}

class _OrdersHeaderState extends State<OrdersHeader> {
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
            "Orders List",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        // ProfileCard()
      ],
    );
  }
}

class OrdersTable extends StatefulWidget {
  const OrdersTable({Key? key}) : super(key: key);

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
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
            "Order List",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("#"),
                ),
                DataColumn(
                  label: Text("Orders Number"),
                ),
                DataColumn(
                  label: Text("Client Name"),
                ),
                DataColumn(
                  label: Text("Deadline"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Service"),
                ),
                DataColumn(
                  label: Text("BD Name"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => userTable(demoRecentFiles[index], index + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow userTable(RecentFile fileInfo, int index) {
  return DataRow(
    cells: [
      DataCell(
        Text(index.toString()),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text(fileInfo.size!)),
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
