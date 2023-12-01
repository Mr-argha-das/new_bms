import 'dart:developer';

import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:admin/screens/venture/user/model/User.list.model.dart';
import 'package:admin/screens/venture/user/service/user.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
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
            "User List",
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

class UserBody extends StatefulWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
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
                  UserTable(),
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

class UserTable extends StatefulWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  Future<UserListModel>? model;
  Future<UserListModel> getData(data) async {
    data = await data.getUserList();
    log(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    model = getData(userService);
    return FutureBuilder<UserListModel>(
      future: model,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User List",
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
                      DataColumn(label: Text("Profile")),
                      DataColumn(
                        label: Text("User Name"),
                      ),
                      DataColumn(
                        label: Text("Phone"),
                      ),
                      DataColumn(
                        label: Text("Email"),
                      ),
                      DataColumn(
                        label: Text("Team Name"),
                      ),
                      DataColumn(
                        label: Text("Edit"),
                      ),
                    ],
                    rows: List.generate(
                      4,
                      (index) => userTable(
                          index: index + 1,
                          name: 'afaf',
                          email: 'aff',
                          number: 'fafaf',
                          teamName: 'afaf',
                          image: 'fafaf'),
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

DataRow userTable({
  required int index,
  required String name,
  required String email,
  required String image,
  required String number,
  required String teamName,
}) {
  return DataRow(
    cells: [
      DataCell(
        Text(index.toString()),
      ),
      DataCell(Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
      )),
      DataCell(Text(name)),
      DataCell(Text(number)),
      DataCell(Text(email)),
      DataCell(Text(teamName)),
      DataCell(Icon(
        Icons.edit_outlined,
        color: Colors.white,
      )),
    ],
  );
}
// userTable(
//                           index: index + 1,
//                           name: snapshot.data!.data[index].name,
//                           email: snapshot.data!.data[index].email,
//                           number: snapshot.data!.data[index].number.toString(),
//                           teamName: snapshot.data!.data[index].roles.name,
//                           image: snapshot.data!.data[index].image),