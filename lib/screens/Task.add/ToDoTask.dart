import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTask extends StatefulWidget {
  const ToDoTask({Key? key}) : super(key: key);

  @override
  State<ToDoTask> createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ToDo Task",
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 42, 46, 62)),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ToDotaskcard(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   height: 35,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 65,
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 42, 46, 62)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Asutosh Barman",
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 500,
                        width: 400,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 46, 62),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ToDo Task Done",
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            CompleatTask(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CompleatTask extends StatefulWidget {
  const CompleatTask({Key? key}) : super(key: key);

  @override
  State<CompleatTask> createState() => _CompleatTaskState();
}

class _CompleatTaskState extends State<CompleatTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 90,
        width: 380,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dmj Frontend design",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Github source |",
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "https://www.github.com/ahit/dmj.git",
                          style: GoogleFonts.inter(
                              fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ToDotaskcard extends StatefulWidget {
  const ToDotaskcard({Key? key}) : super(key: key);

  @override
  State<ToDotaskcard> createState() => _ToDotaskcardState();
}

class _ToDotaskcardState extends State<ToDotaskcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 42, 46, 62),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: Center(
                            child: Text(
                              "1",
                              style: GoogleFonts.inter(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(24, 255, 255, 255)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Points|",
                                        style: GoogleFonts.inter(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade500,
                                    ),
                                    Startdropdown()
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  height: 25,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: GoogleFonts.inter(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Project Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Project Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Project Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Project Name"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("DMJ"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Home page testing"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("https://www.github.com/ahit/dmj.git"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Startdropdown extends StatefulWidget {
  const Startdropdown({Key? key}) : super(key: key);

  @override
  State<Startdropdown> createState() => _StartdropdownState();
}

class _StartdropdownState extends State<Startdropdown> {
  final List<String> items = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          "1",
          style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 80,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
