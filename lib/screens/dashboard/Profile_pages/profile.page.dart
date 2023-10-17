import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 800,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.black,
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
                        ),
                      ),
                      Center(
                        child: Text(
                          "Vishal Goswami",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
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
                          "Staff ID",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "A2G/0141/1072",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
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
                          "Role",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "IT",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
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
                          "Designation",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "Android Developer",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
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
                          "Staff ID",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "A2G/0141/1072",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
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
                    color: Colors.white,
                    child: MyTabbedPage(),
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
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Payroll',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Leaves',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Attendance',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Documents',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Timeline',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Mon. Att.',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Assets Issued',
                style: TextStyle(color: Colors.black),
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
              Center(
                  child: Text(
                'Tab 2 Content',
                style: TextStyle(color: Colors.black),
              )),
              Center(
                  child: Text(
                'Tab 3 Content',
                style: TextStyle(color: Colors.black),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.black),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.black),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.black),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.black),
              )),
              Center(
                  child: Text(
                'Tab 1 Content',
                style: TextStyle(color: Colors.black),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class Profiletabpage extends StatefulWidget {
  const Profiletabpage({Key? key}) : super(key: key);

  @override
  State<Profiletabpage> createState() => _ProfiletabpageState();
}

class _ProfiletabpageState extends State<Profiletabpage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 237, 237, 237),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Address Detail",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 237, 237, 237),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Payroll Detail",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 237, 237, 237),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Bank Account Details",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 237, 237, 237),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Social Media Link",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Staff ID",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
