import 'package:admin/config/coustom.button.dart';
import 'package:admin/config/get.user.data.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/Clients/model/clientlistmodel.dart';
import 'package:admin/screens/Clients/service/client_api_service.dart';
import 'package:admin/screens/orders/views/Pagination.dart';
import 'package:admin/screens/venture/components/widgets/header.ven.dart';
import 'package:admin/screens/venture/user/model/User.list.model.dart';
import 'package:admin/screens/venture/user/service/user.service.dart';
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
    return Material(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 33, 35, 50),
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
          )),
    );
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
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
  Future<ClientListModel>? model;
  Future<ClientListModel> getData() async {
    final clientService = Provider.of<ClientService>(context);
    final getUserData = UserDataGet();
    getUserData.getUserLocalData();
    final data = clientService.getClientList(getUserData.id);
    // data = await data.getClientList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    model = getData();
    return FutureBuilder<ClientListModel>(
      future: model,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 700,
                width: 700,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('assets/images/Ellipse 3.png'),
                        fit: BoxFit.contain)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (snapshot.data == null) ...[
                    Text("Recent Orders not found"),
                  ],
                  if (snapshot.data!.data.isNotEmpty) ...[
                     CustomButton(path: "/client-addr", title: "Client Add"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Container(
                        height: 45,
                        width: 1500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Text(
                                  "#",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: SizedBox(
                                child: Text(
                                  "Client name",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                              Expanded(
                                  child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text("Universitity",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.30,
                      width: 1500,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ListView.builder(
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                    height: 50,
                                    width: 400,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            snapshot.data!.data[index].name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        )),
                                        Expanded(
                                            child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data!.data[index].email,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                            child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${snapshot.data!.data[index].countryCode.toString()} ${snapshot.data!.data[index].number.toString()}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                            child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 35, top:  8, bottom: 8 ),
                                            child: Text(
                                              snapshot.data!.data[index].university,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                      ],
                                    )),
                              );
                            }),
                      ),
                    ),
                  ],
                ],
              )
            ],
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

DataRow userTable(
    {required String id,
    required String name,
    required String phone,
    required String email,
    required String uni,
    required int index}) {
  return DataRow(
    cells: [
      DataCell(
        Text(index.toString()),
      ),
      DataCell(Text(name)),
      DataCell(Text(phone)),
      DataCell(Text(email)),
      DataCell(Text(uni)),
      // DataCell(
      //   PopupMenuButton<String>(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(10.0),
      //       ),
      //     ),
      //     constraints: BoxConstraints(minHeight: 100, minWidth: 20),
      //     color: const Color.fromARGB(255, 42, 46, 62),
      //     icon: Container(
      //       child: Icon(
      //         Icons.more_vert_rounded,
      //         color: Colors.white,
      //       ),
      //     ),
      //     onSelected: (String value) {
      //       // Handle menu item selection
      //       // You can add your logic here based on the selected value
      //     },
      //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      //       PopupMenuItem<String>(
      //         padding: EdgeInsets.all(10),
      //         height: 25,
      //         child: Center(
      //             child: GestureDetector(
      //                 onTap: () {
      //                   showDialog(
      //                     context: context,
      //                     builder: (BuildContext context) {
      //                       return EditFormUser();
      //                     },
      //                   );
      //                 },
      //                 child: Icon(Icons.edit_outlined))),
      //       ),

      //       PopupMenuItem<String>(
      //         padding: EdgeInsets.all(10),
      //         height: 25,
      //         child: Center(
      //             child: GestureDetector(child: Icon(Icons.shopping_cart))),
      //       ),
      //       // Add more menu items as needed
      //     ],
      //   ),
      // ),
    ],
  );
}

class EditFormUser extends StatefulWidget {
  const EditFormUser({Key? key}) : super(key: key);

  @override
  State<EditFormUser> createState() => _EditFormUserState();
}

class _EditFormUserState extends State<EditFormUser> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24.withOpacity(0.1),
        ),
        child: Center(
          child: Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(15)),
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      // controller: teamNameController,
                      decoration: InputDecoration(
                          label: Text("Team Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // controller: teamTypeController,
                      decoration: InputDecoration(
                          label: Text("Team Type"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // final service = AddTeamApi(createDio());
                        // TeamUpdateResModel response =
                        //     await service.updateTeamData(
                        //         id,
                        //         TeamAddModel(
                        //             name:
                        //                 teamNameController.text,
                        //             type:
                        //                 teamTypeController.text,
                        //             vId: ventureid));
                        // Navigator.of(context).pop();
                        // callBack2();
                      },
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text("Save"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
