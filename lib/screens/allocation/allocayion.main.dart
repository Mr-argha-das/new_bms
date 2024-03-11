import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/allocation/view/add.allocation.dart';
import 'package:admin/screens/allocation/view/allocation.list.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllocationAddMain extends StatefulWidget {
  const AllocationAddMain({Key? key}) : super(key: key);

  @override
  State<AllocationAddMain> createState() => _AllocationAddMainState();
}

class _AllocationAddMainState extends State<AllocationAddMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     key: context.read<MenuAppController>().scaffoldKey,
     drawer: SideMenu(title: 'Allocation', context: context,),
     body: SafeArea(child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(Responsive.isDesktop(context))
        Expanded(child: SideMenu(title: 'Allocation', context: context)),
        Expanded(
          flex: 5,
          child: AllocationAddBody())
      ],
     ),),
    );
  }
}


class AllocationListMain extends StatefulWidget {
  const AllocationListMain({Key? key}) : super(key: key);

  @override
  State<AllocationListMain> createState() => _AllocationListMainState();
}

class _AllocationListMainState extends State<AllocationListMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     key: context.read<MenuAppController>().scaffoldKey,
     drawer: SideMenu(title: 'Allocation', context: context,),
     body: SafeArea(child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(Responsive.isDesktop(context))
        Expanded(child: SideMenu(title: 'Allocation', context: context)),
        Expanded(
          flex: 5,
          child: AllocationList())
      ],
     ),),
    );
  }
}