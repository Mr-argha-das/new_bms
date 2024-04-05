import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/Profile_pages/Attendance.dart';
import 'package:admin/screens/dashboard/Profile_pages/Documents.dart';
import 'package:admin/screens/dashboard/Profile_pages/Pages/Leaves.dart';
import 'package:admin/screens/dashboard/Profile_pages/Pages/payroll.dart';
import 'package:admin/screens/dashboard/Profile_pages/Pages/profile.dart';
import 'package:admin/screens/dashboard/Profile_pages/models/profile.models.dart';
import 'package:admin/screens/dashboard/Profile_pages/service/profile.service.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserDetails? userDataModel;
  Future<UserDetails>? futureDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUserData();
    
  }
  getUserData(){
    final dataUser = UserDataGet();
    dataUser.getUserLocalData();
    final profileService =ProfileService(createDio());
    
    Future<UserDetails> data = profileService.getData(dataUser.id);
    data.then((value) {
     setState(() {
       userDataModel = value;
     });
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: userDataModel == null?  Center(
          child: CircularProgressIndicator(),
        ) :Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 800,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: Offset(4, 4))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Beamer.of(context).beamBack();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 220, 220, 220),
                              shape: BoxShape.circle),
                              child: Center(
                                child: Text("${userDataModel!.name[0]}", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36
                                ),),
                              ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "${userDataModel!.name}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 8.0, left: 8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromARGB(255, 237, 202, 202),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Email Id",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${userDataModel!.email}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromARGB(255, 237, 202, 202),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "RMCODE",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${userDataModel!.rmCode}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromARGB(255, 237, 202, 202),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Venture",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${userDataModel!.ventureInfo[0].vName}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromARGB(255, 237, 202, 202),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Teams",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "${userDataModel!.ventureInfo[0].team.name}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 12,
                                offset: Offset(4, 4))
                          ]),
                      child: Center(
                        child: Text("Comming Soon", style: TextStyle(color: Colors.white, fontSize: 35),),
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 8, // The number of tabs you want
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Payroll',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Leaves',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Attendance',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Documents',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Timeline',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Mon. Att.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Assets Issued',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height - 80,
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Profiletabpage()),
              Center(child: PayrollPage()),
              Center(child: LeavesPage()),
              Center(child: AttendancePage()),
              Center(child: DocumentsPage()),
              Center(child: DocumentsPage()),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.white),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.white),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.white),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
