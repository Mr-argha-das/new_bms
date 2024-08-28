import 'dart:developer';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/screens/Clients/views/list.main.dart';
import 'package:admin/screens/loginpage/login.page.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/views/orders.list.dart';
import 'package:admin/screens/team/views/team.list.dart';
import 'package:admin/screens/venture/views/list.venture.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;
class SideMenu extends StatelessWidget {
  final context;
  final String title;
  const SideMenu({
    required this.title,
    required this.context,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getUserData = UserDataGet();
    getUserData.getUserLocalData();
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
            height: getUserData.roleId == "6594278bfeeb0681fa958bd3" ? 100 :290,
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
