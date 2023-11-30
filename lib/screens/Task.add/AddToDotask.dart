import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTaskAdd extends StatefulWidget {
  const ToDoTaskAdd({Key? key}) : super(key: key);

  @override
  State<ToDoTaskAdd> createState() => _ToDoTaskAddState();
}

class _ToDoTaskAddState extends State<ToDoTaskAdd> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 500,
              width: 850,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("TO DO Task !",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Add tasks-amico.png"),
                                fit: BoxFit.cover,
                              )))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 44,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "TO DO Task",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'Project Name',
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )
                                      // Text(
                                      //   "Venture add",
                                      //   style: TextStyle(
                                      //       fontSize: 16,
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.w300),
                                      // ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'Project To Do',
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )
                                      // child: Text(
                                      //   "Venture Name",
                                      //   style: TextStyle(
                                      //       fontSize: 16,
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.w300),
                                      // ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'Github Source',
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration.collapsed(
                                          border: InputBorder.none,
                                          hintText: 'ToDo Note',
                                          hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  height: 35,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 41, 41, 41)),
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
