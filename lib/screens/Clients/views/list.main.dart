import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({Key? key}) : super(key: key);

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                      ClientTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(
                          height: defaultPadding,
                        )
                    ],
                  ))
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
        ));
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({
    Key? key,
  }) : super(key: key);

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
            "Client List",
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

class ClientTable extends StatefulWidget {
  const ClientTable({Key? key}) : super(key: key);

  @override
  State<ClientTable> createState() => _ClientTableState();
}

class _ClientTableState extends State<ClientTable> {
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
            "Client List",
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
                  label: Text("Client Id"),
                ),
                DataColumn(
                  label: Text("Phone"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("University"),
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
              child: Center(child: Icon(Icons.shopping_cart)),
            ),
            // Add more menu items as needed
          ],
        ),
      ),
    ],
  );
}
