import 'dart:developer';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/logicmodels/jugad.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/Clients/views/list.main.dart';
import 'package:admin/screens/loginpage/login.page.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/model/teams.user.model.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:admin/screens/orders/views/orders.list.dart';
import 'package:admin/screens/team/views/team.list.dart';
import 'package:admin/screens/venture/views/list.venture.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatefulWidget {
  final context;
  final String title;
  const SideMenu({
    required this.title,
    required this.context,
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final getUserData = UserDataGet();
  final orderService = OrderService(createDio());
  List<SastaLogic> userList = [];
  List<OrekJugad> jugad = [];

  @override
  void initState() {
    // TODO: implement initState
    getUserData.getUserLocalData();
    super.initState();
    teams = orderService.userTeams(getUserData.id);
    teams.then((value) async {
      if (value.data.teams.length != 0) {
        for (int i = 0; i < value.data.teams.length; i++) {
          await setdata("${value.data.teams[i].id}", i);
        }
      }
    });
  }

  Future<void> setdata(String id, int index) async {
    TeamsUsers user = await orderService.teamsUser("$id");
    List<PagesName> cachedata = [];
    List<PageLKaJugad> jugad2 = [];
    getUserData.getUserLocalData();
    for (int i = 0; i < user.data.users.length; i++) {
      if (int.parse(user.data.users[i].roles) <
          roleChecker(getUserData.roleId)) {
        cachedata.add(PagesName(id: i, name: "${user.data.users[i].name}"));
        jugad2.add(PageLKaJugad(
            i: i,
            id: "${user.data.users[i].id}",
            name: "${user.data.users[i].name}"));
      }
    }
    setState(() {
      userList.add(SastaLogic(index: index, users: cachedata));
      jugad.add(OrekJugad(index: index, data: jugad2));
    });
  }

  late Future<UserJoinTeamsModel> teams;

  @override
  Widget build(BuildContext context) {
    log("===========================================");
    log(getUserData.roleId);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/aheclogo.png"),
          ),

          ListTile(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => MainScreen()));
              },
              horizontalTitleGap: 0.0,
              leading: SvgPicture.asset(
                "assets/icons/menu_profile.svg",
                colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                height: 16,
              ),
              title: Text("Dashboard")),
          DrawerListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Client",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.white,
                )
              ],
            ),
            height: 70,
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
            items: [
              PagesName(id: 1, name: "Client add"),
              PagesName(id: 1, name: "Client List"),
            ],
            onPageChange: (value) {
              if (value == 1) {
                Beamer.of(context).beamToNamed('/client-list');
              } else if (value == 0) {
                Beamer.of(context).beamToNamed('/client-add');
              }
            },
          ),
          DrawerListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Orders",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.white,
                )
              ],
            ),
            height: 100,
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
            onPageChange: (value) {
              if (value == 1) {
                Beamer.of(context).beamToNamed('/orders-list');
              } else if (value == 0) {
                Beamer.of(context).beamToNamed('/add-order');
              }
            },
            items: [
              PagesName(id: 1, name: "Order add"),
              PagesName(id: 1, name: "Order List"),
              // PagesName(id: 1, name: "Order chat"),
            ],
          ),
          DrawerListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Master",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.white,
                )
              ],
            ),
            height:
                getUserData.roleId == "6594278bfeeb0681fa958bd3" ? 100 : 290,
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
            onPageChange: (value) {
              if (getUserData.roleId == "6530f9f7023837a84d6f033c") {
                switch (value) {
                  case 0:
                    // do something
                    Beamer.of(context).beamToNamed('/add-venture');
                    break;
                  case 1:
                    Beamer.of(context).beamToNamed('/venture-list');
                    break;
                  case 2:
                    Beamer.of(context).beamToNamed('/add-team');
                    break;
                  case 3:
                    Beamer.of(context).beamToNamed('/team-list');
                    break;
                  case 4:
                    Beamer.of(context).beamToNamed('/user-add');
                    break;
                  case 5:
                    Beamer.of(context).beamToNamed('/user-list');
                    break;
                  case 6:
                    Beamer.of(context).beamToNamed('/allocation-add');
                    break;
                  case 7:
                    Beamer.of(context).beamToNamed('/allocation-list');
                    break;
                  case 8:
                    Beamer.of(context).beamToNamed('/list-writer-qc');
                    break;
                  case 9:
                    Beamer.of(context).beamToNamed('/add-writer-qc');
                    break;
                }
              }
              if (getUserData.roleId == "6594278bfeeb0681fa958bd3") {
                switch (value) {
                  case 0:
                    Beamer.of(context).beamToNamed('/user-add');
                    break;
                  case 1:
                    Beamer.of(context).beamToNamed('/user-list');
                    break;
                }
              }
              if (getUserData.roleId == "66c738c66d763c91384bc395" ||
                  getUserData.roleId == "66c738e3d2e9475afc5267db") {
                switch (value) {
                  case 0:
                    Beamer.of(context).beamToNamed('/add-team');
                    break;
                  case 1:
                    Beamer.of(context).beamToNamed('/team-list');
                    break;
                  case 2:
                    Beamer.of(context).beamToNamed('/user-add');
                    break;
                  case 3:
                    Beamer.of(context).beamToNamed('/user-list');
                    break;
                }
              }
            },
            items: [
              if (getUserData.roleId == "6530f9f7023837a84d6f033c") ...[
                PagesName(id: 1, name: "Ventuer Add"),
                PagesName(id: 1, name: "Ventuer List"),
                PagesName(id: 1, name: "Team Add "),
                PagesName(id: 1, name: "Team List"),
                PagesName(id: 1, name: "User Add "),
                PagesName(id: 1, name: "User List"),
                PagesName(id: 1, name: "Allocation add"),
                PagesName(id: 1, name: "Allocation List"),
                PagesName(id: 1, name: "Qc, Writer List"),
                PagesName(id: 1, name: "Qc, Writer Add"),
              ],
              if (getUserData.roleId == "6594278bfeeb0681fa958bd3") ...[
                PagesName(id: 1, name: "User Add "),
                PagesName(id: 1, name: "User List"),
              ],
              if (getUserData.roleId == "66c738c66d763c91384bc395" ||
                  getUserData.roleId == "66c738e3d2e9475afc5267db") ...[
                PagesName(id: 1, name: "Team Add "),
                PagesName(id: 1, name: "Team List"),
                PagesName(id: 1, name: "User Add "),
                PagesName(id: 1, name: "User List"),
              ]

              // PagesName(id: 1, name: "Order chat"),
            ],
          ),
          if (getUserData.roleId == "6530f9f7023837a84d6f033c" ||
              getUserData.roleId == "6594278bfeeb0681fa958bd3") ...[
            DrawerListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tasks",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.white,
                  )
                ],
              ),
              height: 100,
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
              onPageChange: (value) {
                if (value == 0) {
                  Beamer.of(context).beamToNamed('/task-list');
                } else if (value == 1) {
                  Beamer.of(context).beamToNamed('/task-add');
                }
              },
              items: [
                PagesName(id: 1, name: "Tasks List"),
                PagesName(id: 1, name: "ADD Task"),
              ],
            )
          ],
          Divider(),
          if (getUserData.roleId == "6530f9f7023837a84d6f033c" ||
              getUserData.roleId == "66c738c66d763c91384bc395" ||
              getUserData.roleId == "66c738e3d2e9475afc5267db" ||
              getUserData.roleId == "65942790feeb0681fa958bd6" ||
              getUserData.roleId == "6594278bfeeb0681fa958bd3") ...[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Teams",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 22),
                )),
            FutureBuilder<UserJoinTeamsModel>(
                future: teams,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.data.teams.length,
                        itemBuilder: (context, index) {
                          return DrawerListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${snapshot.data!.data.teams[index].name}",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              height: 200,
                              svgSrc: "assets/icons/menu_setting.svg",
                              press: () {},
                              onPageChange: (value) {
                                launchUrl(Uri.parse(
                                    "https://squid-app-3-s689g.ondigitalocean.app/user/${jugad[index].data[value].id}/orders"));
                              },
                              items: userList[index].users);
                        });
                  } else if (snapshot.hasError) {
                    return Text("");
                  }
                  return Center(
                    child: SizedBox(),
                  );
                })
          ],

          // DrawerListTile(
          //     title: GestureDetector(
          //       onTap: (){
          //       js.context.callMethod('close');

          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             "Logout",
          //             style: GoogleFonts.montserrat(
          //               color: Colors.white,
          //             ),
          //           ),
          //           SizedBox(
          //             width: 10,
          //           ),
          //         ],
          //       ),
          //     ),
          //     height: 100,
          //     svgSrc: "assets/icons/menu_profile.svg",
          //     press: () {},
          //     onPageChange: (value) {
          //       // if (value == 0) {
          //       //   Beamer.of(context).beamToNamed('/task-list');
          //       // } else if (value == 1) {
          //       //   Beamer.of(context).beamToNamed('/task-add');
          //       // }
          //     },
          //     items: [
          //       // PagesName(id: 1, name: "Tasks List"),
          //       // PagesName(id: 1, name: "ADD Task"),
          //     ],
          //   )

          // DrawerListTile(
          //   title: "Profile",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.items,
    required this.height,
    required this.onPageChange,
  }) : super(key: key);

  final String svgSrc;
  final List<PagesName> items;
  final VoidCallback press;
  final double height;
  final Function onPageChange;
  final Widget title;

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  bool height = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
              onTap: () {
                setState(() {
                  height = !height;
                });
              },
              horizontalTitleGap: 0.0,
              leading: SvgPicture.asset(
                widget.svgSrc,
                colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                height: 16,
              ),
              title: widget.title),
          AnimatedContainer(
            height: height ? widget.height : 0,
            duration: Duration(milliseconds: 100),
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        widget.onPageChange(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 10),
                        child: Text(
                          widget.items[index].name,
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}

class PagesName {
  final int id;
  final String name;

  PagesName({required this.id, required this.name});
}

int roleChecker(
  String myrole,
) {
  bool istrue = false;
  List<Map<String, dynamic>> roles = [
    {
      "_id": "66c738e3d2e9475afc5267db",
      "name": "Assistant Manager",
      "createdAt": "2024-08-22T13:10:59.345Z",
      "updatedAt": "2024-08-22T13:10:59.345Z",
      "__v": 0,
      "p": "4"
    },
    {
      "_id": "66c738c66d763c91384bc395",
      "name": "Manager Operation",
      "createdAt": "2024-08-22T13:10:30.855Z",
      "updatedAt": "2024-08-22T13:10:30.855Z",
      "__v": 0,
      "p": "5"
    },
    {
      "_id": "65942790feeb0681fa958bd6",
      "name": "SME",
      "createdAt": "2024-01-02T15:11:12.105Z",
      "updatedAt": "2024-01-02T15:11:12.105Z",
      "__v": 0,
      "p": "2"
    },
    {
      "_id": "6594278bfeeb0681fa958bd3",
      "name": "BDM",
      "createdAt": "2024-01-02T15:11:07.350Z",
      "updatedAt": "2024-01-02T15:11:07.350Z",
      "__v": 0,
      "p": "3"
    },
    {
      "_id": "65942786feeb0681fa958bd0",
      "name": "BDE",
      "createdAt": "2024-01-02T15:11:02.907Z",
      "updatedAt": "2024-01-02T15:11:02.907Z",
      "__v": 0,
      "p": "1"
    },
    {
      "_id": "6530f9f7023837a84d6f033c",
      "name": "Admin",
      "createdAt": "2023-10-19T09:42:15.052Z",
      "updatedAt": "2023-10-19T09:42:15.052Z",
      "__v": 0,
      "p": "6"
    }
  ];
  int myValue = 0;
  for (int i = 0; i < roles.length; i++) {
    if (roles[i]["_id"] == myrole) {
      myValue = int.parse(roles[i]["p"].toString());
    }
  }
  return myValue;
}
