import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersChatList extends StatefulWidget {
  const OrdersChatList({Key? key}) : super(key: key);

  @override
  State<OrdersChatList> createState() => _OrdersChatListState();
}

class _OrdersChatListState extends State<OrdersChatList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          OrdersChatHeader(),
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
                  OrdersChatTable(),
                  if (Responsive.isMobile(context))
                    SizedBox(
                      height: defaultPadding,
                    )
                ],
              ))
            ],
          )
        ],
      ),
    ));
  }
}

class OrdersChatHeader extends StatefulWidget {
  const OrdersChatHeader({Key? key}) : super(key: key);

  @override
  State<OrdersChatHeader> createState() => _OrdersChatHeaderState();
}

class _OrdersChatHeaderState extends State<OrdersChatHeader> {
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        // ProfileCard()
      ],
    );
  }
}

class OrdersChatTable extends StatefulWidget {
  const OrdersChatTable({Key? key}) : super(key: key);

  @override
  State<OrdersChatTable> createState() => _OrdersChatTableState();
}

class _OrdersChatTableState extends State<OrdersChatTable> {
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
                  label: Text("Orders Number"),
                ),
                DataColumn(
                  label: Text("Client Name"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Service"),
                ),
                if ("admin" == "admin") ...[
                  DataColumn(
                    label: Text("BD name"),
                  ),
                ]
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => orderChatTable(demoRecentFiles[index], index + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow orderChatTable(RecentFile fileInfo, int index) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text(fileInfo.size!)),
      if ("admin" == "admin") ...[
        DataCell(Text(fileInfo.size!)),
      ]
    ],
  );
}
