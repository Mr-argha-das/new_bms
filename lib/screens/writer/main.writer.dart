import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/allocation/view/add.allocation.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriterAddMain extends StatefulWidget {
  const WriterAddMain({Key? key}) : super(key: key);

  @override
  State<WriterAddMain> createState() => _WriterAddMainState();
}

class _WriterAddMainState extends State<WriterAddMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: context.read<MenuAppController>().scaffoldKey,
    drawer: SideMenu(title: 'Writer add', context: context,),
    body: SafeArea(child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(Responsive.isDesktop(context))
        Expanded(child: SideMenu(title: 'Allocation', context: context,)),
        Expanded(
          flex: 5,
          child: AllocationAddBody())
      ],
    )),
    );
  }
}

